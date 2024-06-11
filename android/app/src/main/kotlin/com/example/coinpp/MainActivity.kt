package com.example.coinpp

import android.os.Bundle
import android.util.Log
import com.netcore.android.smartechpush.SmartPush.Companion.getInstance
import com.netcore.smartech_base.SmartechDeeplinkReceivers
import io.flutter.embedding.android.FlutterActivity
import java.lang.ref.WeakReference

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        SmartechDeeplinkReceivers().onReceive(this, intent)


        Log.d("MainActivity", "MainActivity open2")

    }
}

