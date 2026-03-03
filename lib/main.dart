import 'package:flutter/material.dart';
import 'package:suraj_is_hot/app.dart';
import 'package:suraj_is_hot/src/services/notification_service.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  await NotificationService.init();
  await NotificationService.requestPermission();
  runApp(const App());
}
