package com.example.suraj_is_hot

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.BatteryManager
import io.flutter.plugin.common.EventChannel

// One job: receive a battery broadcast, extract temp, forward to Flutter
class BatteryTempReceiver(private val events: EventChannel.EventSink) : BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent?) {
        val rawTemp = intent?.getIntExtra(
            BatteryManager.EXTRA_TEMPERATURE,
            Int.MIN_VALUE
        ) ?: Int.MIN_VALUE

        // Int.MIN_VALUE means Android didn't give us a temperature
        if (rawTemp == Int.MIN_VALUE) {
            events.error("UNAVAILABLE", "Battery temperature not available", null)
            return
        }

        // Android stores temp x10, so 312 = 31.2°C
        val tempCelsius = rawTemp / 10.0
        events.success(tempCelsius)
    }
}
