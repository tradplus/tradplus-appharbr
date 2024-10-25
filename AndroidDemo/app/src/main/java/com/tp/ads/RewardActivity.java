package com.tp.ads;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
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
import com.tradplus.ads.base.adapter.reward.TPRewardAdapter;
import com.tradplus.ads.base.bean.TPAdError;
import com.tradplus.ads.base.bean.TPAdInfo;
import com.tradplus.ads.mgr.interstitial.TPCustomInterstitialAd;
import com.tradplus.ads.mgr.reward.TPCustomRewardAd;
import com.tradplus.ads.open.interstitial.TPInterstitial;
import com.tradplus.ads.open.reward.RewardAdListener;
import com.tradplus.ads.open.reward.TPReward;

import java.util.HashMap;

public class RewardActivity extends Activity{

    private static final String TAG = "AppHarbrSDK";
    private TPReward tpReward;
    private AdQualityAdapterManager adQualityAdapterManager;
    private TPCustomRewardAd tpCustomRewardAd;
    private Object networkObject;
    private TextView textView;
    private int adNetworkId;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_video);

        adQualityAdapterManager = AppHarbrCustomAdapter.getInstance().initializeSDK(this);

        initAndRequestAd();

        findViewById(R.id.btn_load).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                networkObject = AppHarbrCustomAdapter.getInstance().getNetworkObject(tpCustomRewardAd);
                if (adQualityAdapterManager != null && networkObject != null) {
                    Log.i(TAG, "verifyAd networkObject: " + networkObject);
                    VerificationStatus verificationStatus = adQualityAdapterManager.verifyAd(networkObject, AdFormat.REWARDED, "", adNetworkId, "", "",
                            "", "", new HashMap<>(), adQualityListener);
                    textView.setText("-----verificationStatus : " + verificationStatus.name() + "-----");
                }
            }
        });

        findViewById(R.id.btn_show).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (tpCustomRewardAd != null) {
                    if (adQualityAdapterManager != null && networkObject != null) {
                        adQualityAdapterManager.displayingAd(networkObject, AdFormat.REWARDED, "", adNetworkId, "", "",
                                "", "", new HashMap<>(), adQualityListener);
                    }
                    // show ad
                    tpCustomRewardAd.showAd(RewardActivity.this, "");
                }
            }
        });

    }

    private void initAndRequestAd() {
        textView = findViewById(R.id.tv_ad);
        textView.setText("-----initialize AppHarbr-----");


        tpReward  = new TPReward( this, AdUnitIds.reward);
        tpReward.setAutoLoadCallback(true);
        tpReward.setAdListener(adListener);
        tpReward.loadAd();
    }

    private final RewardAdListener adListener = new RewardAdListener() {
        @Override
        public void onAdLoaded(TPAdInfo tpAdInfo) {
            adNetworkId = AppHarbrCustomAdapter.getInstance().getAdSdkId(tpAdInfo.adNetworkId);
            Log.i(TAG, "onAdLoaded: " + adNetworkId);
            tpCustomRewardAd = tpReward.getCustomRewardAd();
            textView.setText("-----ad onAdLoaded , can verifyAd-----");
        }

        @Override
        public void onAdClicked(TPAdInfo tpAdInfo) {
            Log.i(TAG, "onAdClicked: ");
            if (adQualityAdapterManager != null && networkObject != null) {
                adQualityAdapterManager.adClicked(networkObject, AdFormat.REWARDED);
            }
        }

        @Override
        public void onAdImpression(TPAdInfo tpAdInfo) {
            Log.i(TAG, "onAdImpression: ");
        }

        @Override
        public void onAdFailed(TPAdError tpAdError) {

        }

        @Override
        public void onAdClosed(TPAdInfo tpAdInfo) {
            Log.i(TAG, "onAdClosed: ");
            if (adQualityAdapterManager != null && networkObject != null) {
                adQualityAdapterManager.adClosed(networkObject, AdFormat.REWARDED);
            }
        }

        @Override
        public void onAdReward(TPAdInfo tpAdInfo) {

        }

        @Override
        public void onAdVideoStart(TPAdInfo tpAdInfo) {

        }

        @Override
        public void onAdVideoEnd(TPAdInfo tpAdInfo) {

        }

        @Override
        public void onAdVideoError(TPAdInfo tpAdInfo, TPAdError tpAdError) {

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
