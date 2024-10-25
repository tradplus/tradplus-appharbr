package com.tp.ads;

import android.app.Application;

import com.tradplus.ads.open.TradPlusSdk;

public class MyApplication extends Application {

    public static Application application;
    @Override
    public void onCreate() {
        super.onCreate();
        application = this;


        // TradPlus only for Test
        TradPlusSdk.initSdk(getApplicationContext(),"44273068BFF4D8A8AFF3D5B11CBA3ADE");
    }
}
