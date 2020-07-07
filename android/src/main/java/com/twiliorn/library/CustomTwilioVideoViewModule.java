package com.twiliorn.library;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.media.projection.MediaProjectionManager;

import androidx.appcompat.app.AppCompatActivity;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;


public class CustomTwilioVideoViewModule extends ReactContextBaseJavaModule  implements ActivityEventListener {

    private static final int REQUEST_MEDIA_PROJECTION = 100;
    public CustomTwilioVideoView customTwilioVideoView;
    Promise mPromise;
    public CustomTwilioVideoViewModule(ReactApplicationContext reactContext) {
        super(reactContext);
        getReactApplicationContext().addActivityEventListener(this);
    }

    @Override
    public String getName() {
        return "CustomTwilioVideoViewModule";
    }

    @ReactMethod
    public void setIntent(Promise promise) {
        mPromise = promise;
        customTwilioVideoView = CustomTwilioVideoViewManager.getCustomTwilioVideoView();
        Activity activity = getReactApplicationContext().getCurrentActivity();
        MediaProjectionManager mediaProjectionManager = null;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            mediaProjectionManager = (MediaProjectionManager)activity.getSystemService(Context.MEDIA_PROJECTION_SERVICE);
            activity.startActivityForResult(mediaProjectionManager.createScreenCaptureIntent(),REQUEST_MEDIA_PROJECTION);
        }
    }

    @Override
    public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
        if (requestCode == REQUEST_MEDIA_PROJECTION) {
            if (resultCode != AppCompatActivity.RESULT_OK) {
                return;
            }
            customTwilioVideoView.setIntent(data);
            mPromise.resolve("");
        }
    }

    @Override
    public void onNewIntent(Intent intent) {

    }
}