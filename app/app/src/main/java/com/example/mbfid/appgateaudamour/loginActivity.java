package com.example.mbfid.appgateaudamour;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import java.util.concurrent.ExecutionException;

import dao.conectarBD;
import model.usuario;

public class loginActivity extends AppCompatActivity implements View.OnClickListener {

    Button btnVoltarLogin, btnLogin;
    EditText txtEmail, txtSenha;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        //linkando os objetos da tela com as variáveis
        btnVoltarLogin = findViewById(R.id.btnVoltarLogin);
        btnLogin = findViewById(R.id.btnLogin);
        txtEmail = findViewById(R.id.txtEmail);
        txtSenha = findViewById(R.id.txtSenha);

        //eventos OnClick
        btnVoltarLogin.setOnClickListener(this);
        btnLogin.setOnClickListener(this);

    }

    @Override
    public void onClick(View v) {
        switch (v.getId()){
            case R.id.btnVoltarLogin:
                finish();
                break;
            case R.id.btnLogin:
                try{
                    //instâncias das classes
                    usuario usuTela = new usuario();
                    conectarBD logar = new conectarBD(this);

                    //colocando na classe as infromações digitadas
                    usuTela.setEmail_cli(txtEmail.getText().toString());
                    usuTela.setSenha_cli(txtSenha.getText().toString());

                    logar.setUsuClasse(usuTela);
                    logar.execute(0).get();

                    if(logar.getLogin() == true){
                        txtEmail.setText("");
                        txtSenha.setText("");
                        Intent detalhes = new Intent(this,detalhesActivity.class);
                        startActivity(detalhes);
                    }
                    else{
                        usuTela = new usuario();
                    }
                }
                catch (InterruptedException e){
                    e.printStackTrace();
                }
                catch (ExecutionException e){
                    e.printStackTrace();
                }

                break;
        }
    }
}
