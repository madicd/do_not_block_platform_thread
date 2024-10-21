package com.example.native_memory_shared

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    private val examplePlugin = ExamplePlugin()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        examplePlugin.registerMethodChannel(flutterEngine)
    }

    override fun onDestroy() {
        super.onDestroy()
        examplePlugin.unregisterMethodChannel()
    }
}
