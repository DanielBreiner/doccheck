import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationSystem {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initialize({
    String notificationIcon = 'app_icon',
  }) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings(notificationIcon);
    var initializationSettings =
        InitializationSettings(initializationSettingsAndroid, null);
    if (!await flutterLocalNotificationsPlugin
        .initialize(initializationSettings))
      throw Exception("Could not initialize the notification library");
  }

  void notify() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }
}
