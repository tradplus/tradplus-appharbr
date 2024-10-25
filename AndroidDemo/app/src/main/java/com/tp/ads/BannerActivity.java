package com.tp.ads;

import static com.appharbr.sdk.adapter.Constant.AD_SIZE_HEIGHT;

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
import com.tradplus.ads.base.adapter.banner.TPBannerAdImpl;
import com.tradplus.ads.base.bean.TPAdError;
import com.tradplus.ads.base.bean.TPAdInfo;
import com.tradplus.ads.base.bean.TPBaseAd;
import com.tradplus.ads.common.serialization.JSON;
import com.tradplus.ads.mgr.banner.BannerMgr;
import com.tradplus.ads.mgr.interstitial.TPCustomInterstitialAd;
import com.tradplus.ads.open.banner.BannerAdListener;
import com.tradplus.ads.open.banner.TPBanner;

import java.util.HashMap;

public class BannerActivity extends Activity{

    private static final String TAG = "AppHarbrSDK";
    private AdQualityAdapterManager adQualityAdapterManager;
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

        adQualityAdapterManager = AppHarbrCustomAdapter.getInstance().initializeSDK(this);
        initRequestAd();

        HashMap<String, Object> extraData = new HashMap<>();
        extraData.put(Constant.AD_SIZE_WIDTH,320);
        extraData.put(Constant.AD_SIZE_HEIGHT,50);

        findViewById(R.id.btn_load).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                networkObject = AppHarbrCustomAdapter.getInstance().getNetworkObject(tpBaseAd);
                if (adQualityAdapterManager != null && networkObject != null) {
                    Log.i(TAG, "verifyAd networkObject: " + networkObject);
                    VerificationStatus verificationStatus = adQualityAdapterManager.verifyAd(networkObject, AdFormat.BANNER, "", adNetworkId, "", "",
                            "", "", extraData, adQualityListener);
                    textView.setText("-----verificationStatus : " + verificationStatus.name() + "-----");
                }
            }
        });

        findViewById(R.id.btn_show).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (networkObject != null) {
                    if (adQualityAdapterManager != null && networkObject != null) {
                        adQualityAdapterManager.displayingAd(networkObject, AdFormat.INTERSTITIAL, "", adNetworkId, "", "",
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
            adNetworkId = AppHarbrCustomAdapter.getInstance().getAdSdkId(tpAdInfo.adNetworkId);
            Log.i(TAG, "onAdLoaded: " + adNetworkId);
            tpBaseAd = tpBanner.getBannerAd();
            textView.setText("-----ad onAdLoaded , can verifyAd-----");
        }

        @Override
        public void onAdClicked(TPAdInfo tpAdInfo) {
            Log.i(TAG, "onAdClicked: ");
            if (adQualityAdapterManager != null && networkObject != null) {
                adQualityAdapterManager.adClicked(networkObject,AdFormat.BANNER);
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
            if (adQualityAdapterManager != null && networkObject != null) {
                adQualityAdapterManager.adClosed(networkObject,AdFormat.BANNER);
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
