package com.example.mbfid.appgateaudamour;

import android.content.Intent;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

public class splashActivity extends AppCompatActivity implements Runnable {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);

        Handler tempo = new Handler();
        tempo.postDelayed(this,5000);
    }

    @Override
    public void run() {
        Intent tela = new Intent(this, principalActivity.class);
        startActivity(tela);

        finish();
    }
}
