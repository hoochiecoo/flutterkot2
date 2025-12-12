package com.example.hybrid

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.hybrid/nav"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "openNativeScreen") {
                // Запускаем наше второе Activity
                val intent = Intent(this, NativeActivity::class.java)
                startActivity(intent)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }
}
