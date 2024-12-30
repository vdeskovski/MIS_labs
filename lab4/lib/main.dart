import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab4/providers/event_provider.dart';
import 'package:lab4/screens/calendar_screen.dart';
import 'package:lab4/screens/register_screen.dart';
import 'package:lab4/services/notification_services.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(0, 57, 62, 70),
  ),
);
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'location_channel',
        channelName: 'Location Notifications',
        channelDescription: 'Notification channel for location',
        defaultColor: Colors.black,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      )
    ],
  );
  enableNotifications();
  runApp(
    ChangeNotifierProvider(
      create: (_) => EventProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab4',
      theme: theme,
      navigatorKey: navigatorKey,
      home: const RegisterScreen(),
    );
  }
}
