import 'package:flutter/services.dart';

// One job: talk to the Android side and expose battery temp as a Stream
class BatteryTempService {
  // Must match CHANNEL_NAME in BatteryTempChannel.kt exactly
  static const _channel = EventChannel('suraj_is_hot/battery_temp');

  // Returns a stream of battery temperature in Celsius
  // Listen to this like any Dart stream
  Stream<double> get temperatureStream {
    return _channel.receiveBroadcastStream().map((event) => event as double);
  }
}
