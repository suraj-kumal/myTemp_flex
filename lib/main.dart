import 'package:flutter/material.dart';
import 'package:suraj_is_hot/app.dart';
import 'package:suraj_is_hot/src/services/notification_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.notification.request();
  GoogleFonts.config.allowRuntimeFetching = false;
  await NotificationService.init();
  runApp(const App());
}
