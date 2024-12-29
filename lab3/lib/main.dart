import 'package:flutter/material.dart';
import 'package:lab3/screens/joke_type_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lab3/screens/register_screen.dart';
import 'firebase_options.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:lab3/services/notification_services.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(0, 57, 62, 70),
  ),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'daily_joke_channel',
        channelName: 'Daily Joke Notifications',
        channelDescription: 'Notification channel for daily jokes',
        defaultColor: Colors.black,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      )
    ],
  );
  scheduleDailyNotification();
  setupNotificationListener();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    return MaterialApp(
      title: 'Lab3',
      theme: theme,
      home: const RegisterScreen(),
      navigatorKey: navigatorKey,
    );
  }
}
