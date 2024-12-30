import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/event.dart';
import '../providers/event_provider.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CalendarWidgetState();
  }
}

class _CalendarWidgetState extends State<CalendarWidget> {
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   eventProvider = Provider.of<EventProvider>(context);
  // }

  //DateTime _focusedDay = eventProvider.focusedDay;
  //DateTime? _selectedDay;
  Map<DateTime, List<Event>> eventsByDay = {};
  late EventProvider eventProvider;

  // void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
  //   // setState(() {
  //   //   _selectedDay = selectedDay;
  //   //   _focusedDay = focusedDay;
  //   // });
  //   eventProvider.updateFocusedDay(selectedDay);
  // }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(context);
    return Container(
      child: TableCalendar(
        focusedDay: eventProvider.focusedDay,
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2040, 1, 1),
        rowHeight: 55,
        headerStyle:
            const HeaderStyle(formatButtonVisible: false, titleCentered: true),
        availableGestures: AvailableGestures.all,
        onDaySelected: (selectedDay, focusedDay) {
          eventProvider.updateSelectedDay(selectedDay);
          eventProvider.updateFocusedDay(focusedDay);
        },
        selectedDayPredicate: (day) =>
            isSameDay(day, eventProvider.selectedDay),
        eventLoader: (day) {
          return eventProvider.getEventsForDay(day);
        },
      ),
    );
  }
}
