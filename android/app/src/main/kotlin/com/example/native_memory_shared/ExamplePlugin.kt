package com.example.native_memory_shared

import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine
import android.util.Log

class ExamplePlugin {

    private val CHANNEL = "blocking_platform_thread"
    private lateinit var channel: MethodChannel

    fun registerMethodChannel(flutterEngine: FlutterEngine) {
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "work5seconds" -> {
                    // sleep 5s
                    Log.d("ExamplePlugin", "Sleeping 5s")
                    Thread.sleep(5000)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    fun unregisterMethodChannel() {
        channel.setMethodCallHandler(null)
    }
}