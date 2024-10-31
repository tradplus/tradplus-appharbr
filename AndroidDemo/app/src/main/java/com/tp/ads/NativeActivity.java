package com.tp.ads;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.appharbr.adapter.custom.AppHarbrCustomAdapter;
import com.appharbr.sdk.adapter.AdQualityAdapterManager;
import com.appharbr.sdk.adapter.AdQualityListener;
import com.appharbr.sdk.adapter.DirectMediationAdNotVerifyReason;
import com.appharbr.sdk.adapter.VerificationStatus;
import com.appharbr.sdk.engine.AdBlockReason;
import com.appharbr.sdk.engine.adformat.AdFormat;
import com.tradplus.ads.base.bean.TPAdError;
import com.tradplus.ads.base.bean.TPAdInfo;
import com.tradplus.ads.base.bean.TPBaseAd;
import com.tradplus.ads.mgr.nativead.TPCustomNativeAd;
import com.tradplus.ads.open.nativead.NativeAdListener;
import com.tradplus.ads.open.nativead.TPNative;

public class NativeActivity extends Activity{

    private static final String TAG = "AppHarbrSDK";
    private AppHarbrCustomAdapter appHarbrCustomAdapter;
    private TPNative tpNative;
    private Object networkObject;
    private TextView textView;
    private int adNetworkId;
    private FrameLayout adContainer;
    private TPCustomNativeAd nativeAd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_banner);

        appHarbrCustomAdapter = AppHarbrAdapter.getInstance().initializeSDK(this);
        initRequestAd();

        findViewById(R.id.btn_load).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (appHarbrCustomAdapter != null && networkObject != null) {
                    Log.i(TAG, "verifyAd networkObject: " + networkObject);
                    VerificationStatus verificationStatus = appHarbrCustomAdapter.verifyAd(networkObject, AdFormat.NATIVE, "", adNetworkId, "", "",
                            "", "", null, adQualityListener);
                    textView.setText("-----verificationStatus : " + verificationStatus.name() + "-----");
                }
            }
        });

        findViewById(R.id.btn_show).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (appHarbrCustomAdapter != null && networkObject != null) {
                    appHarbrCustomAdapter.onDisplayAd(networkObject, AdFormat.NATIVE, "", adNetworkId, "", "",
                            "", "", null, adQualityListener);
                }
                nativeAd.showAd(adContainer,R.layout.native_ad_list_item,"");
            }
        });

    }

    private void initRequestAd() {
        textView = findViewById(R.id.tv_ad);
        textView.setText("-----initialize AppHarbr-----");

        adContainer = findViewById(R.id.ad_native_container);
        tpNative = new TPNative(NativeActivity.this,AdUnitIds.nativeAd);
        tpNative.setAdListener(mNativeAdListener);
        tpNative.loadAd();
    }

    private final NativeAdListener mNativeAdListener = new NativeAdListener() {
        @Override
        public void onAdLoaded(TPAdInfo tpAdInfo, TPBaseAd tpBaseAd) {
            adNetworkId = AppHarbrAdapter.getInstance().getAdSdkId(tpAdInfo.adNetworkId);
            Log.i(TAG, "onAdLoaded: " + adNetworkId);
            nativeAd = tpNative.getNativeAd();
            networkObject = nativeAd.getNativeAd().getNetworkObj();
            textView.setText("-----ad onAdLoaded , can verifyAd-----");
        }

        @Override
        public void onAdClicked(TPAdInfo tpAdInfo) {
            Log.i(TAG, "onAdClicked: ");
            if (appHarbrCustomAdapter != null && networkObject != null) {
                appHarbrCustomAdapter.onAdClicked(networkObject, AdFormat.NATIVE);
            }
        }

        @Override
        public void onAdImpression(TPAdInfo tpAdInfo) {

        }

        @Override
        public void onAdShowFailed(TPAdError error, TPAdInfo tpAdInfo) {

        }

        @Override
        public void onAdLoadFailed(TPAdError error) {

        }

        @Override
        public void onAdClosed(TPAdInfo tpAdInfo) {
            Log.i(TAG, "onAdClosed: ");
            if (appHarbrCustomAdapter != null && networkObject != null) {
                appHarbrCustomAdapter.onAdClosed(networkObject, AdFormat.NATIVE);
            }
            adContainer.removeAllViews();
        }
    };

    private final AdQualityListener adQualityListener = new AdQualityListener() {
        @Override
        public void onAdIncident(@Nullable Object o, @NonNull AdFormat adFormat, @Nullable String s, int i, @NonNull String s1, @NonNull String s2, @NonNull AdBlockReason[] adBlockReasons, @NonNull AdBlockReason[] adBlockReasons1, long l) {
            Log.i(TAG, "onAdIncident: ");
        }

        @Override
        public void onAdIncidentOnDisplay(@Nullable Object o, @NonNull AdFormat adFormat, @Nullable String s, int i, @NonNull String s1, @NonNull String s2, @NonNull AdBlockReason[] adBlockReasons, @NonNull AdBlockReason[] adBlockReasons1, long l) {
            Log.i(TAG, "onAdIncidentOnDisplay: ");
        }

        @Override
        public void onAdVerified(@Nullable Object o, @NonNull AdFormat adFormat, int i, @NonNull String s, long l) {
            Log.i(TAG, "onAdVerified Object: " + o);
        }

        @Override
        public void onAdNotVerified(@Nullable Object o, @NonNull AdFormat adFormat, @NonNull DirectMediationAdNotVerifyReason directMediationAdNotVerifyReason, int i, @NonNull String s, long l) {
            Log.i(TAG, "onAdNotVerified: " +directMediationAdNotVerifyReason.name());
        }
    };
}
