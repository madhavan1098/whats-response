package com.application.whatsauto

import androidx.annotation.NonNull
import com.application.whatsauto.notification.NotificationListenerPlugin
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private val methodChannelName = "whatsauto.flutter.dev/notification"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            methodChannelName
        ).setMethodCallHandler { call, _ ->
            when (call.method) {
                "openNotification" -> {
                    NotificationListenerPlugin.registerWith(flutterEngine, this)
                }
            }
        }
    }
}
