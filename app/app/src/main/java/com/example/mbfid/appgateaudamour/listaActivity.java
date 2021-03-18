package com.example.mbfid.appgateaudamour;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ListAdapter;
import android.widget.ListView;

import java.util.List;
import java.util.concurrent.ExecutionException;

import dao.conectarBD;
import model.produtoLista;
import utils.produtos;

public class listaActivity extends AppCompatActivity implements View.OnClickListener, AdapterView.OnItemClickListener {

    Button btnVoltarLista;
    ListView lstProd;

    conectarBD listar;
    List<produtoLista> listaProdTela;
    listaAdapter adapter;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_lista);

        //botão voltar
        btnVoltarLista = findViewById(R.id.btnVoltarLista);
        btnVoltarLista.setOnClickListener(this);

        lstProd = findViewById(R.id.lstProd);

        try{
            //chamar o select
            listar = new conectarBD(this);
            listar.execute(3).get();

            //pegar o resultado do select
            listaProdTela = listar.getListaProdClasse();

            //montando o layout: chamando o adapter
            adapter = new listaAdapter(listaProdTela,this);

            //colocando o adapter no list view
            lstProd.setAdapter(adapter);

            lstProd.setOnItemClickListener(this);


        }
        catch (InterruptedException e){
            e.printStackTrace();
        }
        catch (ExecutionException e){
            e.printStackTrace();
        }

    }

    @Override
    public void onClick(View v) {
        finish();
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        produtoLista prodClick = (produtoLista) adapter.getItem(position);

        produtos.setId_prod(prodClick.getId_prod());

        Intent login = new Intent(this, loginActivity.class);
        startActivity(login);
    }
}
