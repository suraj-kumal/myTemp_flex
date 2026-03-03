package com.example.suraj_is_hot

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel

// One job: set up the Flutter channel and manage subscribe/unsubscribe
class BatteryTempChannel(
    private val context: Context,
    messenger: BinaryMessenger
) : EventChannel.StreamHandler {

    private val CHANNEL_NAME = "suraj_is_hot/battery_temp"
    private var receiver: BatteryTempReceiver? = null

    init {
        // Register this class as the handler for the channel
        EventChannel(messenger, CHANNEL_NAME).setStreamHandler(this)
    }

    // Flutter subscribed — start listening to Android OS battery broadcasts
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        events ?: return  // safety: if Flutter gave us no sink, do nothing

        // Clean up any previous receiver before registering a new one
        unregisterReceiver()

        receiver = BatteryTempReceiver(events)

        val filter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        context.registerReceiver(receiver, filter, Context.RECEIVER_EXPORTED)
    }

    // Flutter unsubscribed — stop listening, free resources
    override fun onCancel(arguments: Any?) {
        unregisterReceiver()
    }

    // Safe unregister — guards against "receiver not registered" crash
    private fun unregisterReceiver() {
        try {
            receiver?.let { context.unregisterReceiver(it) }
        } catch (e: IllegalArgumentException) {
            // Already unregistered or never registered — safe to ignore
        } finally {
            receiver = null
        }
    }
}
