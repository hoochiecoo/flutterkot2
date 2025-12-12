package com.example.hybrid

import android.app.Activity
import android.os.Bundle
import android.view.Gravity
import android.widget.LinearLayout
import android.widget.TextView
import android.graphics.Color

class NativeActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Создаем UI программно (без XML для простоты)
        val layout = LinearLayout(this)
        layout.orientation = LinearLayout.VERTICAL
        layout.gravity = Gravity.CENTER
        layout.setBackgroundColor(Color.DKGRAY)

        val textView = TextView(this)
        textView.text = "ЭТО НАТИВ (Activity)"
        textView.textSize = 30f
        textView.setTextColor(Color.WHITE)
        textView.gravity = Gravity.CENTER
        
        val subText = TextView(this)
        subText.text = "Этот экран полностью написан на Kotlin\nНажмите Назад чтобы вернуться во Flutter"
        subText.textSize = 16f
        subText.setTextColor(Color.LTGRAY)
        subText.gravity = Gravity.CENTER
        subText.setPadding(40, 40, 40, 40)

        layout.addView(textView)
        layout.addView(subText)

        setContentView(layout)
    }
}
