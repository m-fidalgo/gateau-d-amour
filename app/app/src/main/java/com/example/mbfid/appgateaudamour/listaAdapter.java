package com.example.mbfid.appgateaudamour;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import java.text.DecimalFormat;
import java.util.List;
import java.util.concurrent.ExecutionException;

import model.produtoLista;
import utils.DownloadImagem;

public class listaAdapter extends BaseAdapter {
    LayoutInflater telaItem;
    List<produtoLista> listaProd;
    Context tela;

    public listaAdapter(List<produtoLista> listaProd, Context tela) {
        this.telaItem = LayoutInflater.from(tela);
        this.listaProd = listaProd;
        this.tela = tela;
    }


    @Override
    public int getCount() {
        return listaProd.size();
    }

    @Override
    public Object getItem(int position) {
        return listaProd.get(position);
    }

    @Override
    public long getItemId(int position) {
        return listaProd.get(position).getId_prod();
    }

    @Override
    public View getView(int position, View view, ViewGroup parent) {

        itemSuporte item;

        //se a view nunca foi criada
        if(view == null){
            view = telaItem.inflate(R.layout.item_lista,null);

            item = new itemSuporte();

            //linkando variáveis aos itens da tela
            item.imgProd = view.findViewById(R.id.imgProd);
            item.lblNome = view.findViewById(R.id.lblNome);
            item.lblPreco = view.findViewById(R.id.lblPreco);

            //atribuindo isso à view
            view.setTag(item);

        }
        else{
            item = (itemSuporte) view.getTag();
        }

        //colocando nos itens o conteúdo da lista
        produtoLista prodLista = listaProd.get(position);
        item.lblNome.setText(prodLista.getNome_prod());
        item.lblPreco.setText("R$" + new DecimalFormat("#0.00").format(prodLista.getPreco_prod()));

        //imagem
        try{
            DownloadImagem img = new DownloadImagem(tela);
            img.execute("https://gateaudamour.000webhostapp.com/" + prodLista.getImagem()).get();

            if(img.getImagemURL() != null){
                item.imgProd.setImageBitmap(img.getImagemURL());
            }
            else{
                item.imgProd.setImageResource(R.drawable.sem_img);
            }
        }
        catch (InterruptedException e){
            e.printStackTrace();
        }
        catch (ExecutionException e){
            e.printStackTrace();
        }

        return view;
    }


    //ajuda a linkar as variaveis e os itens da tela
    private class itemSuporte{
        ImageView imgProd;
        TextView lblNome, lblPreco;
    }
}
