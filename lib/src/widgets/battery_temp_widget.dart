import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:suraj_is_hot/src/services/battery_temp_service.dart';
import 'package:suraj_is_hot/src/utils/temp_status.dart';

class BatteryTempWidget extends StatefulWidget {
  final BatteryTempService service;
  const BatteryTempWidget({super.key, required this.service});

  @override
  State<BatteryTempWidget> createState() => _BatteryTempWidgetState();
}

class _BatteryTempWidgetState extends State<BatteryTempWidget> {
  double? _lastTemp; // caches last known temp — no flashing on rebuild

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: widget.service.temperatureStream,
      initialData: _lastTemp,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _lastTemp = snapshot.data;
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

        // only shows on very first launch
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
