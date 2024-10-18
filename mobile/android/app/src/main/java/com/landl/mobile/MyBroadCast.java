package com.landl.mobile;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class MyBroadCast extends BroadcastReceiver {

    private static final String TAG = "MyBroadcastReceiver";

    @Override
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        Log.d(TAG, "Received broadcast with action: " + action);

        // Xử lý action tùy chỉnh
        if ("com.landl.mobile.CUSTOM_ACTION".equals(action)) {
            Log.d(TAG, "Custom action received!");
        }

        // Xử lý các action mặc định
        if ("android.net.conn.CONNECTIVITY_CHANGE".equals(action)) {
            Log.d(TAG, "Connectivity changed!");
        } else if ("android.intent.action.BATTERY_LOW".equals(action)) {
            Log.d(TAG, "Battery is low!");
        } else if ("android.intent.action.BATTERY_OKAY".equals(action)) {
            Log.d(TAG, "Battery is okay!");
        } else if ("android.intent.action.TIME_CHANGED".equals(action)) {
            Log.d(TAG, "Time has changed!");
        } else if ("android.intent.action.AIRPLANE_MODE_CHANGED".equals(action)) {
            Log.d(TAG, "Airplane mode changed!");
        } else if ("android.intent.action.PHONE_STATE".equals(action)) {
            Log.d(TAG, "Phone state changed!");
        }
        // Thêm các broadcast mặc định khác nếu cần
    }
}
