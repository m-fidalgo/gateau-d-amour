package com.example.mbfid.appgateaudamour;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import utils.produtos;


public class principalActivity extends AppCompatActivity implements View.OnClickListener {

    Button btnBolos, btnCupcakes;




    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_principal);

        btnBolos = findViewById(R.id.btnBolos);
        btnCupcakes = findViewById(R.id.btnCupcakes);

        btnBolos.setOnClickListener(this);
        btnCupcakes.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()){
            case R.id.btnBolos:

                produtos.setId_cat(1);

                Intent bolos = new Intent(this,listaActivity.class);
                startActivity(bolos);

                break;
            case R.id.btnCupcakes:

                produtos.setId_cat(2);

                Intent cupcakes = new Intent(this,listaActivity.class);
                startActivity(cupcakes);

                break;
        }
    }
}
