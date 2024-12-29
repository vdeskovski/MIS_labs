import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/joke_of_the_day.dart';
import '../screens/login_screen.dart';

Future<void> scheduleDailyNotification() async {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'daily_joke_channel',
      title: 'Joke of the Day',
      body: 'Click to see today\'s joke!',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'open_joke',
        label: 'View Joke',
      )
    ],
    schedule: NotificationCalendar(
        timeZone: "GMT+01:00", hour: 16, minute: 0, second: 0, repeats: true),
  );
}

void setupNotificationListener() {
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: onActionReceivedMethod,
  );
}

@pragma("vm:entry-point")
Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
  if (receivedAction.buttonKeyPressed == 'open_joke') {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => const JokeOfTheDay()),
    );
  }
}
