using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class detalhesProd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //select
        DataView dv = (DataView)sqlExibir.Select(DataSourceSelectArguments.Empty);

        if(dv == null)
        {
            Response.Redirect("index.aspx");
        }

        //carregar dados
        lblNome.Text = dv.Table.Rows[0]["nome_prod"].ToString();

        double preco;
        preco = Convert.ToDouble(dv.Table.Rows[0]["preco_prod"].ToString());
        lblPreco.Text = preco.ToString("#0.00");

        lblGenero.Text = dv.Table.Rows[0]["nome_genero"].ToString();
        lblProdFormato.Text = dv.Table.Rows[0]["descr_formato"].ToString();
        lblProdTamanho.Text = dv.Table.Rows[0]["descr_tamanho"].ToString();
        lblProdMedidas.Text = dv.Table.Rows[0]["medidas_tamanho"].ToString();
        lblProdCamadas.Text = dv.Table.Rows[0]["camadas_bolo"].ToString();
        lblProdAndares.Text = dv.Table.Rows[0]["andares_bolo"].ToString();

        lblMassa.Text = dv.Table.Rows[0]["nome_massa"].ToString();
        lblMassaCor.Text = dv.Table.Rows[0]["nome_cor"].ToString();

        lblRecheio.Text = dv.Table.Rows[0]["nome_recheio"].ToString();
        lblRecheioSabor.Text = dv.Table.Rows[0]["desc_sabor"].ToString();

        lblCobertura.Text = dv.Table.Rows[0]["nome_cobertura"].ToString();
        lblCoberturaCor.Text = dv.Table.Rows[0]["corCobertura"].ToString();

        lblDecor.Text = dv.Table.Rows[0]["descr_decor"].ToString();
        lblDecorCor.Text = dv.Table.Rows[0]["corDecor"].ToString();

        imgProd.ImageUrl = "~\\imgs\\produtos\\" + dv.Table.Rows[0]["imagem"].ToString();

        int cat;
        cat = Convert.ToInt32(dv.Table.Rows[0]["id_cat"].ToString());

        if (cat != 1)
        {
            lblDesaparecer1.Visible = false;
            lblDesaparecer2.Visible = false;
            lblDesaparecer3.Visible = false;                 
        }
    }


    protected void btnComprar_Click(object sender, EventArgs e)
    {
        if((string)Session["tipoCli"] != null)
        {
            double qtdDes = Convert.ToDouble(txtQtd.Text.Replace(',', '.'));
            
            if(qtdDes <= 0)
            {
                lblErro.Text = "Quantidade inválida";
                txtQtd.Text = "";
            }
            else
            {
                //se esse é o primeiro item a ser add ao carrinho
                if ((string)Session["novaCompra"] == "SIM")
                {
                    //inserindo na tabela pedidos
                    DateTime dt = DateTime.Now.Date;
                    String data = dt.ToString("yyyy/MM/dd");
                    sqlInserirVenda.InsertParameters["DATA"].DefaultValue = data;
                    sqlInserirVenda.Insert();

                    Session["novaCompra"] = "NÃO";

                    //pegando o id do pedido que acabou de ser feito
                    DataView dv = (DataView)sqlInserirVenda.Select(DataSourceSelectArguments.Empty);
                    Session["idPedido"] = dv.Table.Rows[0]["idPedido"].ToString();
                }

                //preço
                double preco, qtdItens, total;
                preco = Convert.ToDouble(lblPreco.Text);
                qtdItens = Convert.ToDouble(txtQtd.Text);

                total = preco * qtdItens;
                                
                try
                {
                    //inserir na tabela intermediária
                    sqlInserirItens.InsertParameters["TOTAL"].DefaultValue = total.ToString().Replace(',', '.');
                    sqlInserirItens.Insert();
                }
                catch
                {
                    try
                    {
                        //atualizar a tabela intermediária - caso o usuário altere a quantidade
                        sqlInserirItens.UpdateParameters["TOTAL"].DefaultValue = total.ToString().Replace(',', '.');
                        sqlInserirItens.Update();
                    }
                    catch
                    {
                        
                    }
                }

                Response.Redirect("carrinho.aspx");
            }

            
        }
        else
        {
            Response.Redirect("login.aspx");
        }
            
    }
}