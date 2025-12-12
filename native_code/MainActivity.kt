package com.example.hybrid

import android.content.Context
import android.graphics.Color
import android.view.Gravity
import android.view.View
import android.widget.TextView
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Регистрируем фабрику для создания нативного view
        // Идентификатор "native_text_view" должен совпадать с тем, что в lib/main.dart
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("native_text_view", NativeViewFactory())
    }
}

// Фабрика, которая создает View
class NativeViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return NativeView(context, viewId, args)
    }
}

// Сам класс View
class NativeView(context: Context, id: Int, creationParams: Any?) : PlatformView {
    private val textView: TextView = TextView(context)

    override fun getView(): View {
        return textView
    }

    override fun dispose() {}

    init {
        // Настройка нативного TextView
        textView.textSize = 24f
        textView.setTextColor(Color.WHITE)
        textView.setBackgroundColor(Color.DKGRAY)
        textView.gravity = Gravity.CENTER
        textView.text = "это натив"
    }
}
