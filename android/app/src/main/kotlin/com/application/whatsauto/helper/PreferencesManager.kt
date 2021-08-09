package com.application.whatsauto.helper

import android.content.Context
import android.content.SharedPreferences
import android.content.pm.PackageManager
import android.preference.PreferenceManager
import com.application.whatsauto.helper.PreferencesManager
import java.util.HashSet

class PreferencesManager private constructor(private val thisAppContext: Context) {
    private val KEY_SERVICE_ENABLED = "pref_service_enabled"
    private val KEY_GROUP_REPLY_ENABLED = "pref_group_reply_enabled"
    private val KEY_AUTO_REPLY_THROTTLE_TIME_MS = "pref_auto_reply_throttle_time_ms"
    private val KEY_SELECTED_APPS_ARR = "pref_selected_apps_arr"
    private val KEY_IS_APPEND_WATOMATIC_ATTRIBUTION = "pref_is_append_watomatic_attribution"
    private val KEY_GITHUB_RELEASE_NOTES_ID = "pref_github_release_notes_id"
    private val KEY_PURGE_MESSAGE_LOGS_LAST_TIME = "pref_purge_message_logs_last_time"
    private val KEY_PLAY_STORE_RATING_STATUS = "pref_play_store_rating_status"
    private val KEY_PLAY_STORE_RATING_LAST_TIME = "pref_play_store_rating_last_time"
    private val KEY_SHOW_FOREGROUND_SERVICE_NOTIFICATION =
        "pref_show_foreground_service_notification"
    private val KEY_REPLY_CONTACTS = "pref_reply_contacts"
    private val KEY_REPLY_CONTACTS_TYPE = "pref_reply_contacts_type"
    private val KEY_REPLY_CUSTOM_NAMES = "pref_reply_custom_names"
    private val KEY_SELECTED_CONTACT_NAMES = "pref_selected_contacts_names"
    private val _sharedPrefs: SharedPreferences = PreferenceManager.getDefaultSharedPreferences(
        thisAppContext
    )

    /**
     * Execute this code when the singleton is first created. All the tasks that needs to be done
     * when the instance is first created goes here. For example, set specific keys based on new install
     * or app upgrade, etc.
     */
    private fun init() {
        // For new installs, enable all the supported apps
        val newInstall = (!_sharedPrefs.contains(KEY_SERVICE_ENABLED)
                && !_sharedPrefs.contains(KEY_SELECTED_APPS_ARR))
        if (isFirstInstall(thisAppContext)) {
            // Set Append Automatic attribution checked for new installs
            if (!_sharedPrefs.contains(KEY_IS_APPEND_WATOMATIC_ATTRIBUTION)) {
                setAppendWatomaticAttribution(true)
            }
        }
    }

    val isServiceEnabled: Boolean
        get() = _sharedPrefs.getBoolean(KEY_SERVICE_ENABLED, false)

    fun setServicePref(enabled: Boolean) {
        val editor = _sharedPrefs.edit()
        editor.putBoolean(KEY_SERVICE_ENABLED, enabled)
        editor.apply()
    }

    val isGroupReplyEnabled: Boolean
        get() = _sharedPrefs.getBoolean(KEY_GROUP_REPLY_ENABLED, false)

    fun setGroupReplyPref(enabled: Boolean) {
        val editor = _sharedPrefs.edit()
        editor.putBoolean(KEY_GROUP_REPLY_ENABLED, enabled)
        editor.apply()
    }

    var autoReplyDelay: Long
        get() = _sharedPrefs.getLong(KEY_AUTO_REPLY_THROTTLE_TIME_MS, 0)
        set(delay) {
            val editor = _sharedPrefs.edit()
            editor.putLong(KEY_AUTO_REPLY_THROTTLE_TIME_MS, delay)
            editor.apply()
        }

    fun setAppendWatomaticAttribution(enabled: Boolean) {
        val editor = _sharedPrefs.edit()
        editor.putBoolean(KEY_IS_APPEND_WATOMATIC_ATTRIBUTION, enabled)
        editor.apply()
    }

    val isAppendWatomaticAttributionEnabled: Boolean
        get() = _sharedPrefs.getBoolean(KEY_IS_APPEND_WATOMATIC_ATTRIBUTION, true)

    fun setShowForegroundServiceNotification(enabled: Boolean) {
        val editor = _sharedPrefs.edit()
        editor.putBoolean(KEY_SHOW_FOREGROUND_SERVICE_NOTIFICATION, enabled)
        editor.apply()
    }

    val isForegroundServiceNotificationEnabled: Boolean
        get() = _sharedPrefs.getBoolean(KEY_SHOW_FOREGROUND_SERVICE_NOTIFICATION, false)
    var replyToNames: Set<String>?
        get() = _sharedPrefs.getStringSet(KEY_SELECTED_CONTACT_NAMES, HashSet())
        set(names) {
            val editor = _sharedPrefs.edit()
            editor.putStringSet(KEY_SELECTED_CONTACT_NAMES, names)
            editor.apply()
        }
    var customReplyNames: Set<String>?
        get() = _sharedPrefs.getStringSet(KEY_REPLY_CUSTOM_NAMES, HashSet())
        set(names) {
            val editor = _sharedPrefs.edit()
            editor.putStringSet(KEY_REPLY_CUSTOM_NAMES, names)
            editor.apply()
        }
    val isContactReplyEnabled: Boolean
        get() = _sharedPrefs.getBoolean(KEY_REPLY_CONTACTS, false)
    val isContactReplyBlacklistMode: Boolean
        get() = _sharedPrefs.getString(
            KEY_REPLY_CONTACTS_TYPE,
            "pref_blacklist"
        ) == "pref_blacklist"

    companion object {
        private var _instance: PreferencesManager? = null
        @kotlin.jvm.JvmStatic
        fun getPreferencesInstance(context: Context): PreferencesManager? {
            if (_instance == null) {
                _instance = PreferencesManager(context.applicationContext)
            }
            return _instance
        }

        /**
         * Check if it is first install on this device.
         * ref: https://stackoverflow.com/a/34194960
         *
         * @param context
         * @return true if first install or else false if it is installed from an update
         */
        fun isFirstInstall(context: Context): Boolean {
            return try {
                val firstInstallTime =
                    context.packageManager.getPackageInfo(context.packageName, 0).firstInstallTime
                val lastUpdateTime =
                    context.packageManager.getPackageInfo(context.packageName, 0).lastUpdateTime
                firstInstallTime == lastUpdateTime
            } catch (e: PackageManager.NameNotFoundException) {
                e.printStackTrace()
                true
            }
        }
    }

    init {
        init()
    }
}