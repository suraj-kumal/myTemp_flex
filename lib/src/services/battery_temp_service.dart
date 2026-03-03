import 'package:flutter/services.dart';

class BatteryTempService {
  static const _channel = EventChannel('suraj_is_hot/battery_temp');

  // single shared stream — created once, shared across all listeners
  static final Stream<double> _sharedStream = _channel
      .receiveBroadcastStream()
      .map((event) => event as double)
      .asBroadcastStream();

  Stream<double> get temperatureStream => _sharedStream;
}
