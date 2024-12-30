import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lab4/models/event.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import '../services/notification_services.dart';

class DetailEventScreen extends StatefulWidget {
  DetailEventScreen({super.key, required this.event});

  Event event;

  @override
  State<DetailEventScreen> createState() => _DetailEventScreenState();
}

class _DetailEventScreenState extends State<DetailEventScreen> {
  MapController mapController = MapController();
  List<LatLng> routeCoordinates = [];
  String? message;
  StreamSubscription<LocationData>? locationSubscription;
  LocationData? lastKnownLocation;
  bool notificationShown = false;

  TileLayer get openStreetMapTileLayer => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.lab4',
      );

  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return null;
    }

    return await location.getLocation();
  }

  Future<List<LatLng>> fetchRoute(
      LatLng start, LatLng end, String apiKey) async {
    final url = Uri.parse(
        "https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${start.longitude},${start.latitude}&end=${end.longitude},${end.latitude}");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List coordinates = data['features'][0]['geometry']['coordinates'];
      return coordinates.map((coor) => LatLng(coor[1], coor[0])).toList();
    } else {
      throw Exception("Failed to load route");
    }
  }

  void loadRoute() async {
    try {
      final location = await getCurrentLocation();
      if (location != null) {
        print(location);
        final start = LatLng(location.latitude!, location.longitude!);
        final end = LatLng(
            widget.event.location["lat"]!, widget.event.location["lng"]!);
        final route = await fetchRoute(start, end,
            "5b3ce3597851110001cf62480f1c49d429224ef9a517918b75bfcf05");
        setState(() {
          routeCoordinates = route;
          message = null;
        });
      }
    } catch (e) {
      print("Error loading route: $e");
    }
  }

  void checkProximity(
      Event event, double radiusInMeters, LocationData currentLocation) async {
    double distance = Geolocator.distanceBetween(
      currentLocation.latitude!,
      currentLocation.longitude!,
      event.location['lat']!,
      event.location['lng']!,
    );

    if (distance <= radiusInMeters && !notificationShown) {
      showProximityNotification(event);
      notificationShown = true;
    } else if (distance > radiusInMeters) {
      notificationShown = false;
    }
    lastKnownLocation = currentLocation;
  }

  void monitorLocationChanges() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        setState(() {
          message = "Enable location services in settings";
          routeCoordinates = [];
        });
      }
    }
    locationSubscription =
        location.onLocationChanged.listen((LocationData locationData) {
      if (locationData.latitude != null &&
          locationData.longitude != null &&
          lastKnownLocation != locationData) {
        setState(() {
          loadRoute();
          checkProximity(widget.event, 1000, locationData);
          lastKnownLocation = locationData;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    monitorLocationChanges();
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                Text(
                  "Date: ${widget.event.date.toLocal().toString().split(' ')[0]}",
                  style: const TextStyle(fontSize: 21),
                ),
                const Spacer(),
                Text("Time: ${widget.event.time.format(context)}",
                    style: const TextStyle(fontSize: 21))
              ],
            ),
          ),
          Container(
            height: 500,
            child: message != null
                ? Center(
                    child: Text(message!),
                  )
                : routeCoordinates.isNotEmpty
                    ? FlutterMap(
                        mapController: mapController,
                        options: const MapOptions(
                            initialZoom: 13,
                            initialCenter: LatLng(41.998, 21.426)),
                        children: [
                            openStreetMapTileLayer,
                            PolylineLayer(polylines: [
                              Polyline(
                                  points: routeCoordinates,
                                  strokeWidth: 4.0,
                                  color: Colors.blue)
                            ]),
                            MarkerLayer(markers: [
                              Marker(
                                  point: LatLng(widget.event.location["lat"]!,
                                      widget.event.location["lng"]!),
                                  child: GestureDetector(
                                    child: const Icon(
                                      Icons.location_pin,
                                      size: 60,
                                      color: Colors.red,
                                    ),
                                  ))
                            ])
                          ])
                    : const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Fetching shortest path..."),
                            SizedBox(
                              height: 10,
                            ),
                            CircularProgressIndicator()
                          ],
                        ),
                      ),
          )
        ],
      ),
    );
  }
}
