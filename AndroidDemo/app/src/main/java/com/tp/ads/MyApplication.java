package com.tp.ads;

import android.app.Application;

import com.tradplus.ads.open.TradPlusSdk;

public class MyApplication extends Application {

    public static Application application;
    @Override
    public void onCreate() {
        super.onCreate();
        application = this;

        TradPlusSdk.initSdk(getApplicationContext(),AdUnitIds.appId);
    }
}
