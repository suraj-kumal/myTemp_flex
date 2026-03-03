import 'package:flutter/material.dart';

// Sits above App widget, lets any widget change theme from anywhere
class ThemeModeNotifier extends InheritedWidget {
  final ValueNotifier<ThemeMode> notifier;

  const ThemeModeNotifier({
    super.key,
    required this.notifier,
    required super.child,
  });

  static ThemeModeNotifier of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeModeNotifier>()!;
  }

  void setTheme(ThemeMode mode) => notifier.value = mode;

  @override
  bool updateShouldNotify(ThemeModeNotifier oldWidget) =>
      notifier != oldWidget.notifier;
}
