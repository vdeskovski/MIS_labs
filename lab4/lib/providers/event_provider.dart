import 'package:flutter/material.dart';
import '../models/event.dart';

class EventProvider with ChangeNotifier {
  final Map<DateTime, List<Event>> _eventsByDay = {};
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  Map<DateTime, List<Event>> get eventsByDay => _eventsByDay;

  DateTime get focusedDay => _focusedDay;

  DateTime get selectedDay => _selectedDay;

  void updateSelectedDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  void updateFocusedDay(DateTime day) {
    _focusedDay = day;
    notifyListeners();
  }

  List<Event> getEventsForDay(DateTime day) {
    return _eventsByDay[DateTime(day.year, day.month, day.day)] ?? [];
  }

  List<Event> getAllEvents() {
    List<Event> allEvents = [];
    _eventsByDay.forEach((key, value) {
      allEvents.addAll(value);
    });
    return allEvents;
  }

  void addEvent(Event event) {
    final eventDay =
        DateTime(event.date.year, event.date.month, event.date.day);

    if (_eventsByDay[eventDay] == null) {
      _eventsByDay[eventDay] = [];
    }

    _eventsByDay[eventDay]!.add(event);
    notifyListeners();
  }

  void removeEvent(Event event) {
    final eventDay =
        DateTime(event.date.year, event.date.month, event.date.day);

    if (_eventsByDay[eventDay] != null) {
      _eventsByDay[eventDay]!.remove(event);

      if (_eventsByDay[eventDay]!.isEmpty) {
        _eventsByDay.remove(eventDay);
      }

      notifyListeners();
    }
  }
}
