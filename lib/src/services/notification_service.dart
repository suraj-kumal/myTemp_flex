import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:suraj_is_hot/src/widgets/battery_temp_widget.dart';

class NotificationService {
  static const _persistentId = 1;
  static const _alertId = 2;

  static const _persistentChannel = 'battery_temp_channel';
  static const _alertChannel = 'battery_alert_channel';

  // Call once in main.dart before runApp
  static Future<void> init() async {
    await AwesomeNotifications().initialize(
      null, // null = use default app icon
      [
        // Channel 1 — persistent temp notification
        NotificationChannel(
          channelKey: _persistentChannel,
          channelName: 'Battery Temperature',
          channelDescription: 'Shows current battery temperature',
          importance: NotificationImportance.Low,
          playSound: false,
          enableVibration: false,
          channelShowBadge: false,
        ),

        // Channel 2 — threshold alerts
        NotificationChannel(
          channelKey: _alertChannel,
          channelName: 'Battery Alerts',
          channelDescription: 'Alerts when battery temp crosses threshold',
          importance: NotificationImportance.High,
          playSound: true,
          enableVibration: true,
        ),
      ],
    );
  }

  // Request permission — call after init
  static Future<bool> requestPermission() async {
    return await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // Toggle 1 — persistent notification, updates realtime
  static Future<void> showPersistent(double temp) async {
    final status = getTempStatus(temp);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _persistentId,
        channelKey: _persistentChannel,
        title: '${temp.toStringAsFixed(1)} °C',
        body: status.message,
        locked: true, // cant be dismissed by swipe
        autoDismissible: false,
        displayOnForeground: true,
        displayOnBackground: true,
        criticalAlert: false,
        category: NotificationCategory.Status,
      ),
    );
  }

  // Toggle 1 off
  static Future<void> dismissPersistent() async {
    await AwesomeNotifications().cancel(_persistentId);
  }

  // Toggle 2 — alert when threshold crossed
  static Future<void> showAlert(double temp) async {
    final status = getTempStatus(temp);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _alertId,
        channelKey: _alertChannel,
        title: 'suraj_is_hot 🔥',
        body: status.message,
        autoDismissible: true,
        displayOnForeground: true,
        displayOnBackground: true,
        category: NotificationCategory.Event,
      ),
    );
  }
}
