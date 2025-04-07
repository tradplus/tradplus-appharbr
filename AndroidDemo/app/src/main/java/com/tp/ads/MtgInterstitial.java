package com.tp.ads;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.appharbr.adapter.custom.AppHarbrCustomAdapter;
import com.appharbr.sdk.adapter.AdQualityListener;
import com.appharbr.sdk.adapter.DirectMediationAdNotVerifyReason;
import com.appharbr.sdk.adapter.VerificationStatus;
import com.appharbr.sdk.engine.AdBlockReason;
import com.appharbr.sdk.engine.adformat.AdFormat;
import com.tradplus.ads.base.bean.TPAdError;
import com.tradplus.ads.base.bean.TPAdInfo;
import com.tradplus.ads.mgr.interstitial.TPCustomInterstitialAd;
import com.tradplus.ads.open.interstitial.InterstitialAdListener;
import com.tradplus.ads.open.interstitial.TPInterstitial;

import java.util.HashMap;


public class MtgInterstitial extends Activity {

    private static final String TAG = "AppHarbrSDK";
    private TPInterstitial tpInterstitial;
    private AppHarbrCustomAdapter appHarbrCustomAdapter;
    private TPCustomInterstitialAd customInterstitialAd;
    private Object networkObject;
    private TextView textView;
    private int adNetworkId;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_video);

        appHarbrCustomAdapter = AppHarbrAdapter.getInstance().initializeSDK(this);

        initAndRequestAd();

        findViewById(R.id.btn_verifyAd).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                networkObject = AppHarbrAdapter.getInstance().getNetworkObject(customInterstitialAd);
                if (appHarbrCustomAdapter != null && networkObject != null) {
                    Log.i(TAG, "verifyAd networkObject: " + networkObject);
                    VerificationStatus verificationStatus = appHarbrCustomAdapter.verifyAd(networkObject, AdFormat.INTERSTITIAL, "", adNetworkId, "", "",
                            "", "", new HashMap<>(), adQualityListener);
                    textView.setText("-----verificationStatus : " + verificationStatus.name() + "-----");
                }
            }
        });


        findViewById(R.id.btn_displayAd).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (customInterstitialAd != null) {
                    if (appHarbrCustomAdapter != null && networkObject != null) {
                        appHarbrCustomAdapter.onDisplayAd(networkObject, AdFormat.INTERSTITIAL, "", adNetworkId, "", "",
                                "", "", new HashMap<>(), adQualityListener);
                    }
                    // show ad
                    customInterstitialAd.showAd(MtgInterstitial.this,"");
                }
            }
        });

    }

    private void initAndRequestAd() {
        textView = findViewById(R.id.tv_ad);
        textView.setText("-----initialize AppHarbr-----");


        tpInterstitial = new TPInterstitial(this, AdUnitIds.mtg_interstitial);
        tpInterstitial.setAutoLoadCallback(true);
        tpInterstitial.setAdListener(adListener);
        tpInterstitial.loadAd();
    }

    private final InterstitialAdListener adListener = new InterstitialAdListener() {
        @Override
        public void onAdLoaded(TPAdInfo tpAdInfo) {
            adNetworkId = AppHarbrAdapter.getInstance().getAdSdkId(tpAdInfo.adNetworkId);
            Log.i(TAG, "onAdLoaded: " + adNetworkId);
            customInterstitialAd = tpInterstitial.getCustomInterstitialAd();
            findViewById(R.id.btn_verifyAd).setClickable(true);
            textView.setText("-----ad onAdLoaded , verifyAd need to wait-----");

        }

        @Override
        public void onAdFailed(TPAdError tpAdError) {

        }

        @Override
        public void onAdImpression(TPAdInfo tpAdInfo) {
            Log.i(TAG, "onAdImpression: ");
        }

        @Override
        public void onAdClicked(TPAdInfo tpAdInfo) {
            Log.i(TAG, "onAdClicked: ");
            if (appHarbrCustomAdapter != null && networkObject != null) {
                appHarbrCustomAdapter.onAdClicked(networkObject, AdFormat.INTERSTITIAL);
            }
        }

        @Override
        public void onAdClosed(TPAdInfo tpAdInfo) {
            Log.i(TAG, "onAdClosed: ");
            if (appHarbrCustomAdapter != null && networkObject != null) {
                appHarbrCustomAdapter.onAdClosed(networkObject, AdFormat.INTERSTITIAL);
            }

        }

        @Override
        public void onAdVideoError(TPAdInfo tpAdInfo, TPAdError tpAdError) {

        }

        @Override
        public void onAdVideoStart(TPAdInfo tpAdInfo) {

        }

        @Override
        public void onAdVideoEnd(TPAdInfo tpAdInfo) {

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
