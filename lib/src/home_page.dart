import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suraj_is_hot/src/widgets/battery_temp_widget.dart';
import 'package:suraj_is_hot/src/services/battery_temp_service.dart';
import 'package:suraj_is_hot/src/services/notification_service.dart';
import 'package:suraj_is_hot/src/core/theme_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _persistentEnabled = false;
  bool _alertEnabled = false;
  String _lastAlertLevel = '';

  final _batteryService = BatteryTempService();

  @override
  void initState() {
    super.initState();
    _loadPrefs();
    _listenToTemp();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _persistentEnabled = prefs.getBool('persistent') ?? false;
      _alertEnabled = prefs.getBool('alert') ?? false;
    });

    if (_persistentEnabled) {
      try {
        final temp = await _batteryService.temperatureStream.first.timeout(
          const Duration(seconds: 3),
        );
        NotificationService.showPersistent(temp);
      } catch (e) {
        debugPrint('>> failed to restore notification: $e');
      }
    }

    _listenToTemp();
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('persistent', _persistentEnabled);
    await prefs.setBool('alert', _alertEnabled);
  }

  void _listenToTemp() {
    _batteryService.temperatureStream.listen((temp) {
      if (_persistentEnabled) {
        NotificationService.showPersistent(temp);
      }
      if (_alertEnabled) {
        final level = _getLevel(temp);
        if (level != 'normal' && level != _lastAlertLevel) {
          _lastAlertLevel = level;
          NotificationService.showAlert(temp);
        }
      }
    });
  }

  String _getLevel(double temp) {
    if (temp >= 38.0) return 'worst';
    if (temp >= 36.0) return 'hot';
    if (temp >= 32.0) return 'rising';
    return 'normal';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ShadTheme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Suraj is Hot ♨️",
          style: ShadTheme.of(context).textTheme.h4,
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Battery temp card
                BatteryTempWidget(service: _batteryService),

                const SizedBox(height: 24),

                // Toggles card
                ShadCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Toggle 1 — persistent notification
                        _ToggleRow(
                          title: 'Persistent Notification',
                          subtitle: 'Show temp in notification bar',
                          value: _persistentEnabled,
                          onChanged: (val) async {
                            setState(() => _persistentEnabled = val);
                            await _savePrefs();
                            if (val) {
                              // get real temp immediately on toggle
                              final temp = await BatteryTempService()
                                  .temperatureStream
                                  .first;
                              NotificationService.showPersistent(temp);
                            } else {
                              NotificationService.dismissPersistent();
                            }
                          },
                        ),

                        const Divider(height: 24),

                        // Toggle 2 — alerts
                        _ToggleRow(
                          title: 'Temp Alerts',
                          subtitle: 'Alert at 32, 36, 38°C',
                          value: _alertEnabled,
                          onChanged: (val) async {
                            setState(() => _alertEnabled = val);
                            await _savePrefs();
                          },
                        ),

                        const Divider(height: 24),

                        // Toggle 3 — dark mode
                        _ToggleRow(
                          title: 'Dark Mode',
                          subtitle: isDark
                              ? 'Currently dark'
                              : 'Currently light',
                          value: isDark,
                          onChanged: (val) async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('darkMode', val);
                            ThemeModeNotifier.of(
                              context,
                            ).setTheme(val ? ThemeMode.dark : ThemeMode.light);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Reusable toggle row — keeps build method clean
class _ToggleRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: ShadTheme.of(context).textTheme.p),
            Text(subtitle, style: ShadTheme.of(context).textTheme.muted),
          ],
        ),
        ShadSwitch(
          value: value,
          onChanged: onChanged,
          checkedTrackColor: const Color(0xFF606060),
          uncheckedTrackColor: const Color(0xFFD0D0D0),
          thumbColor: const Color(0xFF303030),
        ),
      ],
    );
  }
}
