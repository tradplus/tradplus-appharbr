package com.tp.ads;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.appharbr.adapter.custom.AppHarbrCustomAdapter;
import com.appharbr.sdk.adapter.AdQualityAdapterManager;
import com.appharbr.sdk.configuration.AHSdkConfiguration;
import com.appharbr.sdk.configuration.AHSdkDebug;
import com.appharbr.sdk.engine.AdSdk;
import com.appharbr.sdk.engine.AppHarbr;
import com.appharbr.sdk.engine.InitializationFailureReason;
import com.appharbr.sdk.engine.listeners.OnAppHarbrInitializationCompleteListener;
import com.tradplus.ads.base.adapter.TPBaseAdapter;
import com.tradplus.ads.base.bean.TPBaseAd;
import com.tradplus.ads.mgr.interstitial.TPCustomInterstitialAd;
import com.tradplus.ads.mgr.reward.TPCustomRewardAd;

public class AppHarbrAdapter {

    private final static String TAG = "AppHarbrSDK";
    private static AppHarbrAdapter sInstance;
    private AppHarbrCustomAdapter appHarbrCustomAdapter;

    public synchronized static AppHarbrAdapter getInstance() {
        if (sInstance == null) {
            sInstance = new AppHarbrAdapter();
        }
        return sInstance;
    }


    public AppHarbrCustomAdapter initializeSDK(Context context) {
        if (appHarbrCustomAdapter != null && appHarbrCustomAdapter.isAppHarbrReady()) {
            return appHarbrCustomAdapter;
        }

        Log.i(TAG, "initializeSDK : ");

        AHSdkConfiguration ahSdkConfiguration = new AHSdkConfiguration
                .Builder("dcba05ce-cf66-4113-9f2c-fd6e9f24a850")
                .withDebugConfig(new AHSdkDebug(true))
                .build();

        appHarbrCustomAdapter = AppHarbrCustomAdapter.INSTANCE;

        appHarbrCustomAdapter.initializeSDK(context, ahSdkConfiguration, new OnAppHarbrInitializationCompleteListener() {
            @Override
            public void onSuccess() {
                Log.i(TAG, "AdQualityAdapter onSuccess");
                Toast.makeText(context, "AdQualityAdapter onSuccess", Toast.LENGTH_LONG).show();
            }

            @Override
            public void onFailure(@NonNull InitializationFailureReason initializationFailureReason) {
                if (initializationFailureReason != null) {
                    String readableHumanReason = initializationFailureReason.getReadableHumanReason();
                    Log.i(TAG, "onFailure readableHumanReason: " + readableHumanReason);
                }
            }
        });

        return appHarbrCustomAdapter;
    }

    public Object getNetworkObject(Object object) {
        Object networkObjectAd = null;
        if (object instanceof TPCustomInterstitialAd) {
            TPCustomInterstitialAd tpCustomInterstitialAd = (TPCustomInterstitialAd) object;

            if (tpCustomInterstitialAd != null)  {
                TPBaseAdapter customAdapter = tpCustomInterstitialAd.getCustomAdapter();
                if (customAdapter != null) {
                    networkObjectAd = customAdapter.getNetworkObjectAd();
                }
            }
        }

        if (object instanceof TPCustomRewardAd) {
            TPCustomRewardAd tpCustomRewardAd = (TPCustomRewardAd) object;

            if (tpCustomRewardAd != null)  {
                TPBaseAdapter customAdapter = tpCustomRewardAd.getCustomAdapter();
                if (customAdapter != null) {
                    networkObjectAd = customAdapter.getNetworkObjectAd();
                }
            }
        }

        if (object instanceof TPBaseAd) {
            TPBaseAd tpBaseAd = (TPBaseAd) object;

            if (tpBaseAd != null)  {
                networkObjectAd = tpBaseAd.getRenderView();
            }
        }

        return networkObjectAd;
    }

    public int getAdSdkId(String networkId) {
        int adSdkId = AdSdk.NONE.getId();
        if (TextUtils.isEmpty(networkId)) return adSdkId;
        switch (networkId) {
            case "2":
                adSdkId = AdSdk.ADMOB.getId();
                break;
            case "19":
                adSdkId = AdSdk.PANGLE.getId();
                break;
            case "18":
                adSdkId = AdSdk.MINTEGRAL.getId();
                break;
            case "57":
                adSdkId = AdSdk.BIGO_ADS.getId();
                break;
            case "7":
                adSdkId = AdSdk.VUNGLE.getId();
                break;
        }
        Log.i(TAG, "adSdkId: " + adSdkId);
        return adSdkId;
    }
}
