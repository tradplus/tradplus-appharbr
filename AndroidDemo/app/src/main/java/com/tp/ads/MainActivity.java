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

        bindButton(R.id.btn_rewarded,RewardActivity.class);
        bindButton(R.id.btn_interstitial,InterstitialActivity.class);
        bindButton(R.id.btn_native,NativeActivity.class);
        bindButton(R.id.btn_banner,BannerActivity.class);
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
