package com.example.suraj_is_hot

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Hand off all battery temp logic to its own class
        BatteryTempChannel(
            context = applicationContext,
            messenger = flutterEngine.dartExecutor.binaryMessenger
        )
    }

    override fun onDestroy() {
        super.onDestroy()
        // BatteryTempChannel handles its own cleanup via onCancel
        // Nothing to do here
    }
}
