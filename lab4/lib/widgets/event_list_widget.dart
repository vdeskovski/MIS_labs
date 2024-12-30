import 'package:flutter/material.dart';
import 'package:lab4/models/event.dart';
import 'package:lab4/widgets/event_item_widget.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';

class EventListWidget extends StatefulWidget {
  const EventListWidget({super.key});

  @override
  State<EventListWidget> createState() => _EventListWidgetState();
}

class _EventListWidgetState extends State<EventListWidget> {
  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final selectedDay = eventProvider.selectedDay;
    final events = eventProvider.getEventsForDay(selectedDay);
    return events.isEmpty
        ? const Center(
            child: Text(
              "No exams for this day",
              style: TextStyle(fontSize: 18),
            ),
          )
        : Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (ctx, index) {
                final event = events[index];
                return Dismissible(
                    onDismissed: (direction) {
                      eventProvider.removeEvent(event);
                    },
                    key: ValueKey(event.id),
                    child: EventItemWidget(event: event));
              },
            ),
          );
  }
}
