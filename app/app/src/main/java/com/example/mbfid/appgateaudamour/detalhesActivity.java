package com.example.mbfid.appgateaudamour;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import java.text.DecimalFormat;
import java.util.concurrent.ExecutionException;

import dao.conectarBD;
import model.produtoDetalhes;
import utils.DownloadImagem;
import utils.produtos;

public class detalhesActivity extends AppCompatActivity implements View.OnClickListener {

    Button btnVoltarDetalhes, btn1, btn2, btn3, btn4, btn5;
    TextView lblNomeProd, lblPrecoProd;
    ImageView imgDetalhes;

    Integer nota;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detalhes);

        //linkando os objetos às variáveis
        imgDetalhes = findViewById(R.id.imgDetalhes);
        lblNomeProd = findViewById(R.id.lblNomeProd);
        lblPrecoProd = findViewById(R.id.lblPrecoProd);
        btnVoltarDetalhes = findViewById(R.id.btnVoltarDetalhes);
        btn1 = findViewById(R.id.btn1);
        btn2 = findViewById(R.id.btn2);
        btn3 = findViewById(R.id.btn3);
        btn4 = findViewById(R.id.btn4);
        btn5 = findViewById(R.id.btn5);

        //select
        pesquisar();


        //eventos OnClick
        btnVoltarDetalhes.setOnClickListener(this);
        btn1.setOnClickListener(this);
        btn2.setOnClickListener(this);
        btn3.setOnClickListener(this);
        btn4.setOnClickListener(this);
        btn5.setOnClickListener(this);

    }

    //onClicks
    @Override
    public void onClick(View v) {

        switch (v.getId()){
            case R.id.btnVoltarDetalhes:
                Intent princ = new Intent(this, principalActivity.class);
                startActivity(princ);
                finish();
                break;
            case R.id.btn1:
                nota = 1;
                avaliar();
                break;
            case R.id.btn2:
                nota = 2;
                avaliar();
                break;
            case R.id.btn3:
                nota = 3;
                avaliar();
                break;
            case R.id.btn4:
                nota = 4;
                avaliar();
                break;
            case R.id.btn5:
                nota = 5;
                avaliar();
                break;
        }
    }

    //select
    public void pesquisar(){
        try{
            //instâncias das classes
            produtoDetalhes prodDetTela = new produtoDetalhes();
            conectarBD pesq = new conectarBD(this);

            //colocar o id do produto na classe
            prodDetTela.setId_prod(produtos.getId_prod());
            pesq.setProdDetClasse(prodDetTela);

            //executar a pesquisa
            pesq.execute(1).get();

            //colocat na classe o resultado
            prodDetTela = pesq.getProdDetClasse();

            if(prodDetTela != null){
                lblNomeProd.setText(prodDetTela.getNome_prod());
                lblPrecoProd.setText("R$" + new DecimalFormat("#0.00").format(prodDetTela.getPreco_prod()));

                //imagem
                DownloadImagem img = new DownloadImagem(this);
                img.execute("https://gateaudamour.000webhostapp.com/" + prodDetTela.getImagem()).get();

                if(img.getImagemURL() != null){
                    imgDetalhes.setImageBitmap(img.getImagemURL());
                }
                else{
                    imgDetalhes.setImageResource(R.drawable.sem_img);
                }

                //nota do produto
                Double classProd = prodDetTela.getClass_prod();

                //estrelas de acordo com a nota
                if(classProd > 0 && classProd <= 1){
                    btn1.setBackgroundResource(R.drawable.estrela_sim);
                }
                if(classProd > 1 && classProd <= 2){
                    btn1.setBackgroundResource(R.drawable.estrela_sim);
                    btn2.setBackgroundResource(R.drawable.estrela_sim);
                }
                if(classProd > 2 && classProd <= 3){
                    btn1.setBackgroundResource(R.drawable.estrela_sim);
                    btn2.setBackgroundResource(R.drawable.estrela_sim);
                    btn3.setBackgroundResource(R.drawable.estrela_sim);
                }
                if(classProd > 3 && classProd <= 4){
                    btn1.setBackgroundResource(R.drawable.estrela_sim);
                    btn2.setBackgroundResource(R.drawable.estrela_sim);
                    btn3.setBackgroundResource(R.drawable.estrela_sim);
                    btn4.setBackgroundResource(R.drawable.estrela_sim);
                }
                if(classProd > 4){
                    btn1.setBackgroundResource(R.drawable.estrela_sim);
                    btn2.setBackgroundResource(R.drawable.estrela_sim);
                    btn3.setBackgroundResource(R.drawable.estrela_sim);
                    btn4.setBackgroundResource(R.drawable.estrela_sim);
                    btn5.setBackgroundResource(R.drawable.estrela_sim);
                }
            }
            else {
                prodDetTela = new produtoDetalhes();
                finish();
            }
        }
        catch (InterruptedException e){
            e.printStackTrace();
        }
        catch (ExecutionException e){
            e.printStackTrace();
        }
    }

    //avaliar
    public void avaliar(){
        //instâncias das classes
        produtoDetalhes prodNota = new produtoDetalhes();
        conectarBD avaliar = new conectarBD(this);

        //executar o insert
        prodNota.setNota(nota);
        prodNota.setId_prod(produtos.getId_prod());
        avaliar.setProdDetClasse(prodNota);
        avaliar.execute(2);

        //retomar o pesquisar - update na tela
        Intent tela = new Intent(this, detalhesActivity.class);
        startActivity(tela);
    }
}
