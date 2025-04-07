package com.tp.ads;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import androidx.annotation.IdRes;

public class MainActivity extends Activity  {

    private final static String TAG = "appharbr";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        AppHarbrAdapter.getInstance().initializeSDK(this);
        bindButton(R.id.btn_google, GoogleInterstitial.class);
        bindButton(R.id.btn_pangle, PangleInterstitial.class);
        bindButton(R.id.btn_vungle, VungleInterstitial.class);
        bindButton(R.id.btn_mtg, MtgInterstitial.class);
        bindButton(R.id.btn_bigo, BigoInterstitial.class);
    }

    private void bindButton(@IdRes int id, final Class clz) {
        findViewById(id).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainActivity.this, clz);
                startActivity(intent);
            }
        });
    }


}
