package com.example.coinpp

import android.content.ContentValues.TAG
import android.content.IntentFilter
import android.os.Build
import android.util.Log
import com.netcore.android.Smartech
import com.netcore.android.smartechpush.SmartPush
import com.netcore.android.smartechpush.notification.SMTNotificationListener
import com.netcore.smartech_base.SmartechBasePlugin
import com.netcore.smartech_push.SmartechPushPlugin
import com.netcore.smartech_push.SmartechPushPlugin.Companion.context
import io.flutter.app.FlutterApplication
import org.json.JSONObject
import java.lang.ref.WeakReference

class MyApplication: FlutterApplication(),SMTNotificationListener {

    override fun onCreate() {
        super.onCreate()
        Smartech.getInstance(WeakReference(applicationContext)).initializeSdk(this)

        Smartech.getInstance(WeakReference(applicationContext)).setDebugLevel(9)
        // Add the below line to track app install and update by smartech
        Smartech.getInstance(WeakReference(applicationContext)).trackAppInstallUpdateBySmartech()

        SmartechBasePlugin.initializePlugin(this)
        SmartechPushPlugin.initializePlugin(this)
        SmartPush.getInstance(WeakReference(SmartechPushPlugin.context)).setSMTNotificationListener(this)
       // val deeplinkReceiver = MyDeeplink()
       // val filter = IntentFilter("com.smartech.EVENT_PN_INBOX_CLICK")
       // if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.CUPCAKE) {
         //   context.registerReceiver(deeplinkReceiver, filter, RECEIVER_EXPORTED)
        //} else {
          //  context.registerReceiver(deeplinkReceiver, filter)
        //}

        try {
            val smartPush = SmartPush.getInstance(WeakReference(context))
            smartPush.fetchAlreadyGeneratedTokenFromFCM()
        } catch (e: Exception) {
            Log.e(TAG, "Fetching FCM token failed.")
        }
    }

    override fun onTerminate() {
        super.onTerminate()
        Log.d("onTerminate","onTerminate")
    }

    //implement override Smartech Notification method

    //implement override Smartech Notification method
    override fun getSmartechNotifications(payload: String, source: Int) {
       // SmartPush.getInstance(WeakReference(SmartechPushPlugin.context)).renderNotification(payload, source)

    }


    }


