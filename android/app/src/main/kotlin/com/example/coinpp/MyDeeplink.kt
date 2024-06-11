package com.example.coinpp

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.util.Log
import androidx.core.content.ContextCompat.startActivity
import com.netcore.android.SMTBundleKeys

class MyDeeplink:BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        try {
            val bundleExtra = intent?.extras
            bundleExtra?.let {
                val deepLinkSource = it.getString(SMTBundleKeys.SMT_KEY_DEEPLINK_SOURCE)
                val deepLink = it.getString(SMTBundleKeys.SMT_KEY_DEEPLINK)
                val customPayload = it.getString(SMTBundleKeys.SMT_KEY_CUSTOM_PAYLOAD)
                if (deepLink != null && deepLink.isNotEmpty()) {
                    // handle deepLink for redirection. Here you can use deepLinkSource for redirection if required
                    Log.d("deeplink", deepLink.toString());

                    // Create a URI from the deep link string
                    val uri = Uri.parse(deepLink)

                    // Create an intent with the deep link URI
                    val intent = Intent(Intent.ACTION_VIEW, uri).apply {
                        flags = Intent.FLAG_ACTIVITY_NEW_TASK
                    }

                    // Start the activity with the intent
                    context?.startActivity(intent);
                }
                if (customPayload != null && customPayload.isNotEmpty()) {
                    // handle your custom payload based on deeplink source like below if required
                    Log.d("custompayloadplink", customPayload);
                }
            }
        } catch (t: Throwable) {
            Log.e("DeeplinkReceiver", "Error occurred in deeplink:${t.localizedMessage}")
        }
    }




}
