import 'package:flutter/material.dart';
import 'package:lab4/models/event.dart';
import 'package:lab4/screens/add_event_screen.dart';
import 'package:lab4/widgets/calendar_widget.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';
import '../services/auth_service.dart';
import '../widgets/event_list_widget.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  late List<Event> events;

  @override
  void initState() {
    super.initState();
    events = [];
  }

  void showAddScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const AddEventScreen()));
  }

  void _signOut() async {
    await AuthService().logout(context);
  }

  var userEmail = AuthService().getUserEmail();

  @override
  Widget build(BuildContext context) {
    late EventProvider eventProvider = Provider.of<EventProvider>(context);
    events = eventProvider.getAllEvents();
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello, $userEmail"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: showAddScreen, icon: const Icon(Icons.add)),
          IconButton(
            onPressed: _signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Column(
        children: [CalendarWidget(), EventListWidget()],
      ),
    );
  }
}
