import 'package:awesome_notifications/awesome_notifications.dart';

import '../models/event.dart';

Future<void> showProximityNotification(Event event) async {
  int notificationId = event.id.hashCode;
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: notificationId,
      channelKey: 'location_channel',
      title: 'You are near ${event.title}',
      body: 'You are within 1 kilometer of ${event.title}!',
      notificationLayout: NotificationLayout.Default,
    ),
  );
}

Future<void> enableNotifications() async {
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();

  if (!isAllowed) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  } else {
    print("Notifications are already enabled.");
  }
}
