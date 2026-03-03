import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:suraj_is_hot/src/widgets/battery_temp_widget.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static const _persistentId = 1; // ongoing temp notification
  static const _alertId = 2; // threshold alert notification

  // Call once in main.dart before runApp

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _plugin.initialize(settings: settings);

    // Explicitly create channels on Android 15
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        'battery_temp_channel',
        'Battery Temperature',
        description: 'Shows current battery temperature',
        importance: Importance.low,
      ),
    );

    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        'battery_alert_channel',
        'Battery Alerts',
        description: 'Alerts when battery temp crosses threshold',
        importance: Importance.high,
      ),
    );
  }

  // Toggle 1 — update persistent notification with current temp
  static Future<void> showPersistent(double temp) async {
    final status = getTempStatus(temp);

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'battery_temp_channel',
        'Battery Temperature',
        channelDescription: 'Shows current battery temperature',
        importance: Importance.low, // silent, no sound
        priority: Priority.low,
        ongoing: true, // cant be dismissed by swipe
        onlyAlertOnce: true,
        icon: '@mipmap/ic_launcher',
      ),
    );

    await _plugin.show(
      id: _persistentId,
      title: '${temp.toStringAsFixed(1)} °C',
      body: status.message,
      notificationDetails: details,
    );
  }

  // Toggle 1 off — dismiss persistent notification
  static Future<void> dismissPersistent() async {
    await _plugin.cancel(id: _persistentId);
  }

  // Toggle 2 — alert when threshold crossed
  static Future<void> showAlert(double temp) async {
    final status = getTempStatus(temp);

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'battery_alert_channel',
        'Battery Alerts',
        channelDescription: 'Alerts when battery temp crosses threshold',
        importance: Importance.high, // makes sound + pops up
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
    );

    await _plugin.show(
      id: _alertId,
      title: 'suraj_is_hot 🔥',
      body: status.message,
      notificationDetails: details,
    );
  }
}
