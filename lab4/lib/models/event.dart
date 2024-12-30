import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Event {
  final String id;
  final String title;
  final DateTime date;
  final TimeOfDay time;
  final Map<String, double> location;

  Event({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
  }) : id = uuid.v4();

  Event.all(
      {required this.id,
      required this.title,
      required this.date,
      required this.time,
      required this.location});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'time': {'hour': time.hour, 'minute': time.minute},
      'location': {'lat': location['lat'], 'lng': location['lng']}
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event.all(
        id: map['id'],
        title: map['title'],
        date: DateTime.parse(map['date']),
        time: TimeOfDay(
          hour: map['time']['hour'],
          minute: map['time']['minute'],
        ),
        location: Map<String, double>.from(map['location']));
  }
}
