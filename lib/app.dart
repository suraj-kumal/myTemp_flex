import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:suraj_is_hot/src/core/app_theme.dart';
import 'package:suraj_is_hot/src/home_page.dart';
import 'package:suraj_is_hot/src/core/theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // Start with system theme, toggle can override
  final _themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('darkMode') ?? false;
    _themeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return ThemeModeNotifier(
      notifier: _themeModeNotifier,
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: _themeModeNotifier,
        builder: (context, themeMode, _) {
          return ShadApp(
            themeMode: themeMode,
            theme: ShadThemeData(
              brightness: Brightness.light,
              colorScheme: const AppLightColorScheme(),
              radius: BorderRadius.circular(10),
              textTheme: ShadTextTheme(family: 'AdFont'),
            ),
            darkTheme: ShadThemeData(
              brightness: Brightness.dark,
              colorScheme: const AppDarkColorScheme(),
              radius: BorderRadius.circular(10),
              textTheme: ShadTextTheme(family: 'Adfont'),
            ),
            builder: (context, child) {
              final isDark =
                  ShadTheme.of(context).brightness == Brightness.dark;
              return Theme(
                data: isDark ? AppThemeData.dark() : AppThemeData.light(),
                child: child!,
              );
            },

            home: const HomePage(),
          );
        },
      ),
    );
  }
}
