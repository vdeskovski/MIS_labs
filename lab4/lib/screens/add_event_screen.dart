import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../providers/event_provider.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  MapController mapController = MapController();
  LocationData? _currentLocationData;
  LatLng? _selectedLatLng;
  final location = Location();
  TimeOfDay? selectedTime = TimeOfDay.now();

  final titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  // void showMapScreen(){
  //   Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>));
  // }
  void _addEvent() {
    final event = Event(
      title: titleController.text,
      date: DateTime.now(),
      location: {
        'latitude': _selectedLatLng!.latitude,
        'longitude': _selectedLatLng!.longitude,
      },
      time: TimeOfDay.now(),
    );

    // You can add the event to your event provider or save it to a database
    // eventProvider.addEvent(event);
  }

  Future<void> _getCurrentLocation() async {
    final hasPermission = await location.requestPermission();
    if (hasPermission != PermissionStatus.granted) return;

    final currentLocation = await location.getLocation();
    setState(() {
      _currentLocationData = currentLocation;
      _selectedLatLng =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      mapController.move(
          LatLng(_currentLocationData?.latitude ?? 0,
              _currentLocationData?.longitude ?? 0),
          16);
    });
  }

  TileLayer get openStreetMapTileLayer => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.lab4',
      );

  void _onMapTapped(LatLng tappedLocation) {
    setState(() {
      _selectedLatLng = tappedLocation;
    });
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //       content: Text(
    //           "Selected Location: ${_selectedLatLng!.latitude}, ${_selectedLatLng!.longitude}")),
    // );
  }

  @override
  void initState() {
    super.initState();
    //_getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    DateTime selectedDate = eventProvider.focusedDay;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add an Exam'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Picked Date (${selectedDate.toLocal().toString().split(' ')[0]})",
                  style: const TextStyle(fontSize: 21),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Title is required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          selectedTime = time;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Text(
                                    'Selected Time: ${time.format(context)}')),
                          );
                        }
                      },
                      child: const Text('Pick Time'),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Text("Select a location:"),
                Container(
                  height: 500,
                  child: FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                          initialZoom: 13,
                          initialCenter: const LatLng(41.99, 21.42),
                          onTap: (_, tappedLoc) => _onMapTapped(tappedLoc)),
                      children: [
                        openStreetMapTileLayer,
                        if (_selectedLatLng != null)
                          MarkerLayer(markers: [
                            Marker(
                                point: _selectedLatLng!,
                                child: GestureDetector(
                                  child: const Icon(
                                    Icons.location_pin,
                                    size: 60,
                                    color: Colors.red,
                                  ),
                                ))
                          ])
                      ]),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (_selectedLatLng != null) {
                        Event event = Event(
                          title: titleController.text,
                          date: DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            // selectedTime!.hour ?? 0,
                            // selectedTime!.minute ?? 0,
                          ),
                          location: {
                            "lat": _selectedLatLng!.latitude,
                            "lng": _selectedLatLng!.longitude
                          },
                          time: selectedTime!,
                        );
                        eventProvider.addEvent(event);
                        //FireStorageService().addEventToUser(event);
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("You must select a location!")),
                        );
                      }
                    }
                    // Go back to the previous screen
                  },
                  child: const Text('Add Exam'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
