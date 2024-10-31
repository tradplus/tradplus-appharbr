package com.tp.ads;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.appharbr.adapter.custom.AppHarbrCustomAdapter;
import com.appharbr.sdk.adapter.AdQualityAdapterManager;
import com.appharbr.sdk.adapter.AdQualityListener;
import com.appharbr.sdk.adapter.Constant;
import com.appharbr.sdk.adapter.DirectMediationAdNotVerifyReason;
import com.appharbr.sdk.adapter.VerificationStatus;
import com.appharbr.sdk.engine.AdBlockReason;
import com.appharbr.sdk.engine.adformat.AdFormat;
import com.tradplus.ads.base.bean.TPAdError;
import com.tradplus.ads.base.bean.TPAdInfo;
import com.tradplus.ads.base.bean.TPBaseAd;
import com.tradplus.ads.open.banner.BannerAdListener;
import com.tradplus.ads.open.banner.TPBanner;

import java.util.HashMap;

public class BannerActivity extends Activity{

    private static final String TAG = "AppHarbrSDK";
    private AppHarbrCustomAdapter appHarbrCustomAdapter;
    private TPBaseAd tpBaseAd;
    private Object networkObject;
    private TextView textView;
    private int adNetworkId;
    private FrameLayout adContainer;
    private TPBanner tpBanner;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_banner);

        appHarbrCustomAdapter = AppHarbrAdapter.getInstance().initializeSDK(this);
        initRequestAd();

        HashMap<String, Object> extraData = new HashMap<>();
        extraData.put(Constant.AD_SIZE_WIDTH,320);
        extraData.put(Constant.AD_SIZE_HEIGHT,50);

        findViewById(R.id.btn_load).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                networkObject = AppHarbrAdapter.getInstance().getNetworkObject(tpBaseAd);
                if (appHarbrCustomAdapter != null && networkObject != null) {
                    Log.i(TAG, "verifyAd networkObject: " + networkObject);
                    VerificationStatus verificationStatus = appHarbrCustomAdapter.verifyAd(networkObject, AdFormat.BANNER, "", adNetworkId, "", "",
                            "", "", extraData, adQualityListener);
                    textView.setText("-----verificationStatus : " + verificationStatus.name() + "-----");
                }
            }
        });

        findViewById(R.id.btn_show).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (networkObject != null) {
                    if (appHarbrCustomAdapter != null && networkObject != null) {
                        appHarbrCustomAdapter.onDisplayAd(networkObject, AdFormat.INTERSTITIAL, "", adNetworkId, "", "",
                                "", "", extraData, adQualityListener);
                    }

                    // show ad
                    if (networkObject instanceof View) {
                        View renderView = (View) networkObject;
                        if (renderView.getParent() != null) {
                            ((ViewGroup) renderView.getParent()).removeView(renderView);
                        }
                        adContainer.addView(renderView);
                    }

                }
            }
        });

    }

    private void initRequestAd() {
        textView = findViewById(R.id.tv_ad);
        textView.setText("-----initialize AppHarbr-----");

        adContainer = findViewById(R.id.ad_banner_container);
        tpBanner = new TPBanner(BannerActivity.this);
        tpBanner.closeAutoShow();
        tpBanner.setAdListener(mBannerAdListener);
        tpBanner.loadAd(AdUnitIds.banner);
    }

    private final BannerAdListener mBannerAdListener = new BannerAdListener() {
        @Override
        public void onAdLoaded(TPAdInfo tpAdInfo) {
            adNetworkId = AppHarbrAdapter.getInstance().getAdSdkId(tpAdInfo.adNetworkId);
            Log.i(TAG, "onAdLoaded: " + adNetworkId);
            tpBaseAd = tpBanner.getBannerAd();
            textView.setText("-----ad onAdLoaded , can verifyAd-----");
        }

        @Override
        public void onAdClicked(TPAdInfo tpAdInfo) {
            Log.i(TAG, "onAdClicked: ");
            if (appHarbrCustomAdapter != null && networkObject != null) {
                appHarbrCustomAdapter.onAdClicked(networkObject,AdFormat.BANNER);
            }
        }

        @Override
        public void onAdImpression(TPAdInfo tpAdInfo) {
            Log.i(TAG, "onAdImpression: ");
        }

        @Override
        public void onAdShowFailed(TPAdError error, TPAdInfo tpAdInfo) {

        }

        @Override
        public void onAdLoadFailed(TPAdError error) {
            Log.i(TAG, "onAdLoadFailed: ");
        }

        @Override
        public void onAdClosed(TPAdInfo tpAdInfo) {
            Log.i(TAG, "onAdClosed: ");
            if (appHarbrCustomAdapter != null && networkObject != null) {
                appHarbrCustomAdapter.onAdClosed(networkObject,AdFormat.BANNER);
            }
        }

        @Override
        public void onBannerRefreshed() {

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
