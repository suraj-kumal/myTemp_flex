import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:suraj_is_hot/src/utils/temp_status.dart';
import 'package:suraj_is_hot/src/services/battery_temp_service.dart';

class NotificationService {
  static const _persistentId = 1;
  static const _alertId = 2;
  static const _persistentChannel = 'battery_temp_channel';
  static const _alertChannel = 'battery_alert_channel';

  // tracks last alert level to avoid duplicate alerts
  static String _lastAlertLevel = '';

  // Call once in main.dart before runApp
  static Future<void> init() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: _persistentChannel,
        channelName: 'Battery Temperature',
        channelDescription: 'Shows current battery temperature',
        importance: NotificationImportance.Low,
        playSound: false,
        enableVibration: false,
        channelShowBadge: false,
      ),
      NotificationChannel(
        channelKey: _alertChannel,
        channelName: 'Battery Alerts',
        channelDescription: 'Alerts when battery temp crosses threshold',
        importance: NotificationImportance.High,
        playSound: true,
        enableVibration: true,
      ),
    ]);
  }

  // Request permission — call after init
  static Future<bool> requestPermission() async {
    return await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // Start listening to battery temp stream directly
  // Call once in main.dart after init
  static void startListening({
    required BatteryTempService service,
    required bool Function() isPersistentEnabled,
    required bool Function() isAlertEnabled,
  }) {
    service.temperatureStream.listen((temp) {
      // persistent notification — update every broadcast
      if (isPersistentEnabled()) {
        showPersistent(temp);
      }

      // alert — only fire when level changes
      if (isAlertEnabled()) {
        final level = _getLevel(temp);
        if (level != 'normal' && level != _lastAlertLevel) {
          _lastAlertLevel = level;
          showAlert(temp);
        }
      }
    });
  }

  // Reset alert level — call when alert toggle is turned off and on
  static void resetAlertLevel() => _lastAlertLevel = '';

  static String _getLevel(double temp) {
    if (temp >= tempWorst) return 'worst';
    if (temp >= tempHot) return 'hot';
    if (temp >= tempNormal) return 'rising';
    return 'normal';
  }

  // Show persistent notification
  static Future<void> showPersistent(double temp) async {
    final status = getTempStatus(temp);
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _persistentId,
        channelKey: _persistentChannel,
        title: '${temp.toStringAsFixed(1)} °C',
        body: status.message,
        locked: true,
        autoDismissible: false,
        displayOnForeground: true,
        displayOnBackground: true,
        criticalAlert: false,
        category: NotificationCategory.Status,
      ),
    );
  }

  // Dismiss persistent notification
  static Future<void> dismissPersistent() async {
    await AwesomeNotifications().cancel(_persistentId);
  }

  // Show alert notification
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
