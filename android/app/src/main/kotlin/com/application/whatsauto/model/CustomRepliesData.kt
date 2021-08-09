package com.application.whatsauto.model

import android.app.Activity
import android.content.Context
import android.content.SharedPreferences
import android.service.notification.StatusBarNotification
import android.text.Editable
import com.application.whatsauto.R
import com.application.whatsauto.helper.PreferencesManager
import com.application.whatsauto.helper.PreferencesManager.Companion.getPreferencesInstance
import org.json.JSONArray
import org.json.JSONException

/**
 * Manages user entered custom auto reply text data.
 */
class CustomRepliesData {
    private var thisAppContext: Context? = null
    private var preferencesManager: PreferencesManager? = null
    var _prefix = "flutter."

    private constructor() {}
    private constructor(context: Context) {
        thisAppContext = context.applicationContext
        _sharedPrefs = context.applicationContext
            .getSharedPreferences(APP_SHARED_PREFS, Activity.MODE_PRIVATE)
        preferencesManager = getPreferencesInstance(thisAppContext!!)
        init()
    }

    /**
     * Execute this code when the singleton is first created. All the tasks that needs to be done
     * when the instance is first created goes here. For example, set specific keys based on new install
     * or app upgrade, etc.
     */
    private fun init() {
        // Set default auto reply message on first install
        if (!_sharedPrefs!!.contains(_prefix + KEY_CUSTOM_REPLY_ALL)) {
            set(thisAppContext!!.getString(R.string.auto_reply_default_message))
        }
    }

    /**
     * Stores given auto reply text to the database and sets it as current
     *
     * @param customReply String that needs to be set as current auto reply
     * @return String that is stored in the database as current custom reply
     */
    fun set(customReply: String?): String? {
        if (!isValidCustomReply(customReply)) {
            return null
        }
        val previousCustomReplies = all
        previousCustomReplies.put(customReply)
        if (previousCustomReplies.length() > MAX_NUM_CUSTOM_REPLY) {
            previousCustomReplies.remove(0)
        }
        val editor = _sharedPrefs!!.edit()
        editor.putString(_prefix + KEY_CUSTOM_REPLY_ALL, previousCustomReplies.toString())
        editor.apply()
        return customReply
    }

    /**
     * Stores given auto reply text to the database and sets it as current
     *
     * @param customReply Editable that needs to be set as current auto reply
     * @return String that is stored in the database as current custom reply
     */
    fun set(customReply: Editable?): String? {
        return if (customReply != null) set(customReply.toString()) else null
    }

    /**
     * Get last set auto reply text
     * Prefer using [::getOrElse][CustomRepliesData] to avoid `null`
     *
     * @return Auto reply text or `null` if not set
     */
    fun get(): String? {
        val allCustomReplies = all
        if (allCustomReplies.length() > 0) {
            return allCustomReplies.join("\n")
        }
        return null
    }

    /**
     * Get last set auto reply text if present or else return {@param defaultText}
     *
     * @param defaultText default auto reply text
     * @return Return auto reply text if present or else return given {@param defaultText}
     */
    private fun getOrElse(defaultText: String?): String {
        val currentText = get()
        return currentText ?: defaultText!!
    }

    fun getTextToSendOrElse(): String {
        var currentText = getOrElse(thisAppContext!!.getString(R.string.auto_reply_default_message))
        if (preferencesManager!!.isAppendWatomaticAttributionEnabled) {
            currentText += """
                
                
                $RTL_ALIGN_INVISIBLE_CHAR${thisAppContext!!.getString(R.string.whatsapp_suffix)}
                """.trimIndent()
        }
        return currentText
    }
fun setUserSendData(sbn:StatusBarNotification,){
    _sharedPrefs?.edit()?.putInt(_prefix + KEY_USER_SEND_DATA_COUNT,sbn.user.hashCode())?.apply()
}
    private val all: JSONArray
        get() {
            var allCustomReplies = JSONArray()
            try {
                allCustomReplies =
                    JSONArray(_sharedPrefs!!.getString(_prefix + KEY_CUSTOM_REPLY_ALL, "[]"))
            } catch (e: JSONException) {
                e.printStackTrace()
            }
            return allCustomReplies
        }

    companion object {
        const val KEY_CUSTOM_REPLY_ALL = "SELECTED_TEMPLATE_DATA"
        const val KEY_USER_SEND_DATA_COUNT="send_data_count"
        const val MAX_NUM_CUSTOM_REPLY = 10
        const val MAX_STR_LENGTH_CUSTOM_REPLY = 500
        const val RTL_ALIGN_INVISIBLE_CHAR =
            " \u200F\u200F\u200E " // https://android.stackexchange.com/a/190024
        private val APP_SHARED_PREFS = "FlutterSharedPreferences"
        private var _sharedPrefs: SharedPreferences? = null
        private var _INSTANCE: CustomRepliesData? = null
        fun getInstance(context: Context): CustomRepliesData? {
            if (_INSTANCE == null) {
                _INSTANCE = CustomRepliesData(context)
            }
            return _INSTANCE
        }

        fun isValidCustomReply(userInput: String?): Boolean {
            return userInput != null &&
                    !userInput.isEmpty() &&
                    userInput.length <= MAX_STR_LENGTH_CUSTOM_REPLY
        }

        fun isValidCustomReply(userInput: Editable?): Boolean {
            return userInput != null &&
                    isValidCustomReply(userInput.toString())
        }
    }
}