import 'package:flutter/material.dart';
import 'package:lab4/models/event.dart';
import 'package:lab4/screens/detail_event_screen.dart';

class EventItemWidget extends StatelessWidget {
  EventItemWidget({super.key, required this.event});

  Event event;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => DetailEventScreen(event: event)));
      },
      child: Card(
        child: ListTile(
          title: Text(event.title),
          subtitle: Text(
            "Time: ${event.time.format(context)}",
          ),
        ),
      ),
    );
  }
}
