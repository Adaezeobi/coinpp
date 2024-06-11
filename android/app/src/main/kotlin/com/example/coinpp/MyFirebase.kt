package com.example.coinpp

import android.util.Log
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.netcore.android.smartechpush.SmartPush
import com.netcore.smartech_push.SmartechPushPlugin
import com.netcore.smartech_push.SmartechPushPlugin.Companion.context
import org.json.JSONObject
import java.lang.ref.WeakReference

class MyFirebase: FirebaseMessagingService() {

    override fun onNewToken(token: String) {
        super.onNewToken(token)
        Log.i("fcmtoken", token)
        SmartPush.getInstance(WeakReference(this)).setDevicePushToken(token)//fetch token
    }
    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        super.onMessageReceived(remoteMessage)
        val isPushFromSmartech:Boolean = SmartPush.getInstance(WeakReference(applicationContext)).isRemoteNotificationFromSmartech(remoteMessage)
        if(isPushFromSmartech){
            SmartPush.getInstance(WeakReference(applicationContext)).handleRemotePushNotification(remoteMessage)
        } else {
            // Notification received from other sources
        }
    }

}