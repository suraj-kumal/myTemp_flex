import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const double tempNormal = 32.0;
const double tempHot = 36.0;
const double tempWorst = 38.0;

({String message, Color color, IconData icon}) getTempStatus(double temp) {
  if (temp >= tempWorst) {
    return (
      message: "game kheldai xas? mobile padkinxa",
      color: const Color(0xFFEF4444),
      icon: LucideIcons.flame,
    );
  } else if (temp >= tempHot) {
    return (
      message: "phone tatyo, nachala phone",
      color: const Color(0xFFF97316),
      icon: LucideIcons.thermometerSun,
    );
  } else if (temp >= tempNormal) {
    return (
      message: "tatdai xa hai phone",
      color: const Color(0xFFEAB308),
      icon: LucideIcons.thermometer,
    );
  } else {
    return (
      message: "chiso nai xa",
      color: const Color(0xFF22C55E),
      icon: LucideIcons.circleCheck,
    );
  }
}
