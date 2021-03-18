package dao;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.widget.Toast;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.produtoDetalhes;
import model.produtoLista;
import model.usuario;
import utils.criptografia;
import utils.produtos;

public class conectarBD extends AsyncTask<Integer, Object, Boolean> {

    Connection conexao;
    Context tela;
    ProgressDialog dialogo;
    int op;
    criptografia cripto;


    public conectarBD(Context tela) {
        this.tela = tela;
        cripto = new criptografia("bblm");
    }

    //chamar os métodos
    @Override
    protected Boolean doInBackground(Integer... integers) {
        Boolean resp = null;
        op = integers[0];
        connect();

        switch (op){
            case 0:
                resp = logar();
                break;
            case 1:
                resp = pesqDetalhes();
                break;
            case 2:
                resp = nota();
                break;
            case 3:
                resp = listar();
                break;
        }

        return resp;
    }

    //dialogo - conectando
    @Override
    protected void onPreExecute() {
        super.onPreExecute();

        dialogo = new ProgressDialog(tela);
        dialogo.setMessage("Conectando...");
        dialogo.show();
    }

    //após a execução - mensagens
    @Override
    protected void onPostExecute(Boolean aBoolean) {
        super.onPostExecute(aBoolean);

        switch (op){
            case 0:
                if(aBoolean == false){
                    Toast.makeText(tela,"Usuário não cadastrado",Toast.LENGTH_SHORT).show();
                }
                break;
            case 1:
                if(aBoolean == false){
                    Toast.makeText(tela,"Não foi possível obter detalhes",Toast.LENGTH_SHORT).show();
                }
                break;
            case 2:
                if(aBoolean == true){
                    Toast.makeText(tela,"Avaliação feita com sucesso",Toast.LENGTH_SHORT).show();
                }
                else{
                    Toast.makeText(tela,"Não foi possível avaliar o produto",Toast.LENGTH_SHORT).show();
                }
            case 3:
                if (aBoolean == false){
                    Toast.makeText(tela,"Esse tipo de produto não existe",Toast.LENGTH_SHORT).show();
                }
                break;
        }

        dialogo.dismiss();
        disconnect();
    }

    //conectar com o BD
    public Boolean connect(){
        try{
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            conexao = DriverManager.getConnection("jdbc:mysql://172.16.61.220/gateaudamour","root","aluno");
            return true;
        }
        catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    //fechar a conexão
    public void disconnect(){
        try{
            conexao.close();
        }
        catch (SQLException e){
            e.printStackTrace();
        }
    }

/////LOGIN

    //instância da classe usuário
    private usuario usuClasse;
    public usuario getUsuClasse() {
        return usuClasse;
    }
    public void setUsuClasse(usuario usuClasse) {
        this.usuClasse = usuClasse;
    }

    //variável login
    private Boolean login;
    public Boolean getLogin() {
        return login;
    }
    public void setLogin(Boolean login) {
        this.login = login;
    }


    //método logar()
    public Boolean logar(){
        try{
            String sql = "SELECT * FROM CLIENTE WHERE EMAIL_CLI = ? AND SENHA_CLI  = ?";
            PreparedStatement comando = conexao.prepareStatement(sql);

            comando.setString(1,cripto.encrypt(usuClasse.getEmail_cli().getBytes()).replace("\n", ""));

            String senha = usuClasse.getSenha_cli();
            comando.setString(2,cripto.encrypt(senha.getBytes()).replace("\n", ""));

            //comando.setString(1,"9eYFM/roWQa0QtrYb86m17PWt6UDQmlwrZno+MCjrdk=");
            //comando.setString(2,"f7nxTFaF40nrl1nKiWXOFA==");

            ResultSet tabela = comando.executeQuery();
            if(tabela.next())
            {
                login = true;
                return true;
            }
            else
            {
                usuClasse = null;
                login = false;
                return false;
            }
        }
        catch (SQLException e){
            e.printStackTrace();
            login = false;
            return false;
        }
    }

/////DETALHES

    //instância da classe produtoDetalhes
    private produtoDetalhes prodDetClasse;
    public produtoDetalhes getProdDetClasse() {
        return prodDetClasse;
    }
    public void setProdDetClasse(produtoDetalhes prodDetClasse) {
        this.prodDetClasse = prodDetClasse;
    }

    //método pesqDetalhes()
    public Boolean pesqDetalhes(){
        try{

            //pesquisar
            String sql = "select id_prod, nome_prod, preco_prod, imagem, class_prod from produto " +
                    " where id_prod = ?";
            PreparedStatement comando = conexao.prepareStatement(sql);
            comando.setInt(1,prodDetClasse.getId_prod());

            ResultSet tabela = comando.executeQuery();

            if(tabela.next()){
                //colocar na classe o resultado da pesquisa
                prodDetClasse.setId_prod(tabela.getInt("id_prod"));
                prodDetClasse.setNome_prod(tabela.getString("nome_prod"));
                prodDetClasse.setImagem(tabela.getString("imagem"));
                prodDetClasse.setClass_prod(tabela.getDouble("class_prod"));
                prodDetClasse.setPreco_prod(tabela.getDouble("preco_prod"));
                return true;
            }
            else{
                prodDetClasse = null;
                return false;
            }
        }
        catch (SQLException e){
            e.printStackTrace();
            return false;
        }
    }

    //método nota()
    public Boolean nota(){
        try{
            //id do produto
            Integer id = prodDetClasse.getId_prod();

            //inserir em classificação
            String sql = "INSERT INTO CLASSIFICACAO VALUES(0,?,?)";
            PreparedStatement comando = conexao.prepareStatement(sql);
            comando.setInt(1,id);
            comando.setInt(2,prodDetClasse.getNota());
            comando.executeUpdate();

            //pegar os valores para fazer a média
            String sql1 = "SELECT SUM(NOTA) AS SOMA, COUNT(NOTA) AS QTD FROM CLASSIFICACAO WHERE ID_PROD = ?";
            PreparedStatement comando1 = conexao.prepareStatement(sql1);
            comando1.setInt(1,id);
            ResultSet tabela1 = comando1.executeQuery();

            if(tabela1.next()){
                Double soma = tabela1.getDouble("SOMA");
                Integer qtd = tabela1.getInt("QTD");
                Double classFinal = soma / qtd;

                //atualizar a tabela produto
                String sql2 = "UPDATE PRODUTO SET CLASS_PROD = ? WHERE ID_PROD = ?";
                PreparedStatement comando2 = conexao.prepareStatement(sql2);
                comando2.setDouble(1,classFinal);
                comando2.setInt(2,id);
                comando2.executeUpdate();
                return true;
            }
            else{
                return false;
            }
        }
        catch (SQLException e){
            e.printStackTrace();
            return false;
        }
    }

/////LISTA

    //instância da classe produtoLista
    private produtoLista prodListaClasse;
    public produtoLista getProdListaClasse() {
        return prodListaClasse;
    }
    public void setProdListaClasse(produtoLista prodListaClasse) {
        this.prodListaClasse = prodListaClasse;
    }

    //lista da classe produtoLista
    private List<produtoLista> listaProdClasse = new ArrayList<produtoLista>();

    public List<produtoLista> getListaProdClasse() {
        return listaProdClasse;
    }

    public void setListaProdClasse(List<produtoLista> listaProdClasse) {
        this.listaProdClasse = listaProdClasse;
    }

    //método listar()
    public Boolean listar(){
        try{
            //a consulta ao BD
            String sql = "select p.id_prod, p.nome_prod, p.preco_prod, p.imagem, p.status_prod, c.id_cat, " +
                    "p.id_prod from produto p inner join tamanho t on p.id_tamanho = t.id_tamanho " +
                    "inner join categoria c on c.id_cat = t.id_cat where c.id_cat = ? and " +
                    "p.status_prod = 'Permanente' and p.nome_prod != 'SELECIONE' ";

            PreparedStatement comando = conexao.prepareStatement(sql);
            comando.setInt(1, produtos.getId_cat());

            ResultSet tabelaMemoria = comando.executeQuery();

            //enquanto há resultados
            while (tabelaMemoria.next()){

                //instância temporária da classe
                produtoLista prodTemp = new produtoLista();

                //colocando na classe os resultados do select
                prodTemp.setId_prod(tabelaMemoria.getInt("id_prod"));
                prodTemp.setId_cat(tabelaMemoria.getInt("id_cat"));
                prodTemp.setImagem(tabelaMemoria.getString("imagem"));
                prodTemp.setNome_prod(tabelaMemoria.getString("nome_prod"));
                prodTemp.setPreco_prod(tabelaMemoria.getDouble("preco_prod"));

                //adicionando à lista essa classe
                listaProdClasse.add(prodTemp);

            }

            return true;
        }
        catch (SQLException e){
            e.printStackTrace();
            return false;
        }
    }

}
