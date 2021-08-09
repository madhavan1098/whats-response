package com.application.whatsauto.notification

import android.app.Notification
import android.app.PendingIntent
import android.content.Intent
import android.os.Bundle
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import android.util.Log
import androidx.core.app.RemoteInput
import com.application.whatsauto.model.CustomRepliesData
import com.application.whatsauto.model.NotificationWear
import org.json.JSONException
import org.json.JSONObject


/**
 * Notification listening service. Intercepts notifications if permission is given to do so.
 */
class NotificationListener : NotificationListenerService() {
    override fun onNotificationPosted(sbn: StatusBarNotification) {
        try {
            val notificationWear: NotificationWear = NotificationUtils.extractWearNotification(sbn)
            // Possibly transient or non-user notification from WhatsApp like
            // "Checking for new messages" or "WhatsApp web is Active"
            if (notificationWear.remoteInputs.isEmpty()) {
                return
            }
            // Retrieve package name to set as title.
            val packageName = sbn.packageName
            // Retrieve extra object from notification to extract payload.
            val extras = sbn.notification.extras
            val packageMessage = extras?.getCharSequence(Notification.EXTRA_TEXT).toString()
            val packageText = extras?.getCharSequence("android.title").toString()
            val packageExtra = convertBumbleToJsonString(sbn.notification.extras)
            // Pass data from one activity to another.
            val intent = Intent(NOTIFICATION_INTENT)
            intent.putExtra(NOTIFICATION_PACKAGE_NAME, packageName)
            intent.putExtra(NOTIFICATION_PACKAGE_MESSAGE, packageMessage)
            intent.putExtra(NOTIFICATION_PACKAGE_TEXT, packageText)
            intent.putExtra(NOTIFICATION_PACKAGE_EXTRA, packageExtra)
            sendBroadcast(intent)
            sendReply(sbn)
        } catch (error: Exception) {
            error.printStackTrace()
            Log.w(
                "Crashing aborted ",
                "An exception occurred, I do not know yet what causes that error\nIt seams that a bundle is null on a notification received or it is just a bug\nIf you did not receive the notification please raise a complain on my github"
            )
        }
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        return START_STICKY
    }

    /*https://github.com/adeekshith/watomatic*/
    private fun sendReply(sbn: StatusBarNotification) {
        val notificationWear: NotificationWear = NotificationUtils.extractWearNotification(sbn)
        // Possibly transient or non-user notification from WhatsApp like
        // "Checking for new messages" or "WhatsApp web is Active"
        if (notificationWear.remoteInputs.isEmpty()) {
            return
        }
        val customRepliesData = CustomRepliesData.getInstance(this)
        val remoteInputs: Array<RemoteInput?> =
            arrayOfNulls(notificationWear.remoteInputs.size)
        val localIntent = Intent()
        localIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        val localBundle = Bundle() //notificationWear.bundle;
        for ((i, remoteIn) in notificationWear.remoteInputs.withIndex()) {
            remoteInputs[i] = remoteIn
            localBundle.putCharSequence(
                remoteInputs[i]?.resultKey,
                customRepliesData?.getTextToSendOrElse()
            )
        }
        RemoteInput.addResultsToIntent(remoteInputs, localIntent, localBundle)
        try {
            if (notificationWear.pendingIntent != null) {
                notificationWear.pendingIntent.send(this, 0, localIntent)
                cancelNotification(sbn.key)
            }
        } catch (e: PendingIntent.CanceledException) {
            Log.e("REPLY MESSAGE", "replyToLastNotification error: " + e.localizedMessage)
        }
    }

    companion object {
        const val NOTIFICATION_INTENT = "notification_event"
        const val NOTIFICATION_PACKAGE_NAME = "package_name"
        const val NOTIFICATION_PACKAGE_MESSAGE = "package_message"
        const val NOTIFICATION_PACKAGE_TEXT = "package_text"
        const val NOTIFICATION_PACKAGE_EXTRA = "package_extra"
    }

    private fun convertBumbleToJsonString(extra: Bundle): String {
        val json = JSONObject()
        val keys = extra.keySet()
        for (key in keys) {
            try {
                json.put(key, JSONObject.wrap(extra.get(key)))
            } catch (e: JSONException) {
                e.printStackTrace()
            }
        }
        return json.toString()
    }
}