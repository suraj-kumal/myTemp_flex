import 'package:flutter/material.dart';
import 'package:suraj_is_hot/src/services/battery_temp_service.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const double _tempRising = 20.0;
const double _tempHot = 36.0;
const double _tempWorst = 38.0;

({String message, Color color, IconData icon}) getTempStatus(double temp) {
  if (temp >= _tempWorst) {
    return (
      message: "game kheldai xas? mobile padkinxa",
      color: const Color(0xFFEF4444),
      icon: LucideIcons.flame,
    );
  } else if (temp >= _tempHot) {
    return (
      message: "phone tatyo, nachala phone",
      color: const Color(0xFFF97316),
      icon: LucideIcons.thermometerSun,
    );
  } else if (temp >= _tempRising) {
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

class BatteryTempWidget extends StatefulWidget {
  final BatteryTempService service;
  const BatteryTempWidget({super.key, required this.service});

  @override
  State<BatteryTempWidget> createState() => _BatteryTempWidgetState();
}

class _BatteryTempWidgetState extends State<BatteryTempWidget> {
  double? _lastTemp; // caches last known temp to avoid flashing

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: widget.service.temperatureStream,
      initialData: _lastTemp, // shows last known temp on rebuild
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _lastTemp = snapshot.data; // always cache latest
          final temp = snapshot.data!;
          final status = getTempStatus(temp);

          return ShadCard(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${temp.toStringAsFixed(1)} °C',
                    style: ShadTheme.of(context).textTheme.h1,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(status.icon, color: status.color, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        status.message,
                        style: ShadTheme.of(
                          context,
                        ).textTheme.p.copyWith(color: status.color),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return ShadCard(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Error: ${snapshot.error}',
                style: ShadTheme.of(context).textTheme.p,
              ),
            ),
          );
        }

        // only shows on very first launch before any data arrives
        return ShadCard(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Reading temperature...',
              style: ShadTheme.of(context).textTheme.p,
            ),
          ),
        );
      },
    );
  }
}
