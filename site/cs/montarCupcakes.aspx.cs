using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class montarCupcakes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void ddlFormato_SelectedIndexChanged(object sender, EventArgs e)
    {
        //permitir a escolha do tamanho
        if (ddlFormato.SelectedItem.Text == "SELECIONE")
        {
            lbl1.Text = "Selecione um valor";
        }
        else
        {
            lbl1.Text = null;
            ddlTamanho.Enabled = true;
        }
    }

    protected void ddlTamanho_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlTamanho.SelectedItem.Text == "SELECIONE")
        {
            lblTam.Text = "Selecione um valor";
        }
        else
        {
            lblTam.Text = null;

            //preço do tamanho
            DataView dvTam = (DataView)sqlTamanhoEsc.Select(DataSourceSelectArguments.Empty);
            Session["precoTam"] = Convert.ToDouble(dvTam.Table.Rows[0]["preco_tamanho"].ToString());

            //calcular para mostrar
            double precoTam;
            precoTam = (double)Session["precoTam"];
            lblPreco.Text = "R$" + precoTam.ToString("#0.00");
        }
    }

    protected void ddlMassa_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlMassa.SelectedItem.Text == "SELECIONE")
        {
            lblMassa.Text = "Selecione um valor";
        }
        else
        {
            try
            {
                lblMassa.Text = null;

                //preço da massa
                DataView dvMassa = (DataView)sqlMassaEsc.Select(DataSourceSelectArguments.Empty);
                Session["precoAdcMassa"] = Convert.ToDouble(dvMassa.Table.Rows[0]["precoAdc_massa"].ToString());

                //calcular para mostrar
                double precoTam, precoAdcMassa, preco1;
                precoTam = (double)Session["precoTam"];
                precoAdcMassa = (double)Session["precoAdcMassa"];
                preco1 = precoTam + precoAdcMassa;
                lblPreco.Text = "R$" + preco1.ToString("#0.00");
            }
            catch
            {

            }

        }

    }


    protected void ddlCobertura_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCobertura.SelectedItem.Text == "SELECIONE")
        {
            lblCob.Text = "Selecione um valor";
        }
        else
        {
            try
            {
                lblCob.Text = null;

                //preço da cobertura
                DataView dvCobertura = (DataView)sqlCoberturaEsc.Select(DataSourceSelectArguments.Empty);
                Session["precoAdcCobertura"] = Convert.ToDouble(dvCobertura.Table.Rows[0]["precoAdc_cobertura"].ToString());

                //calcular para mostrar
                double precoTam, precoAdcMassa, precoAdcCobertura, preco2;
                precoTam = (double)Session["precoTam"];
                precoAdcMassa = (double)Session["precoAdcMassa"];
                precoAdcCobertura = (double)Session["precoAdcCobertura"];
                preco2 = precoTam + precoAdcMassa + precoAdcCobertura;
                lblPreco.Text = "R$" + preco2.ToString("#0.00");
            }
            catch
            {

            }
        }

    }

    protected void ddlDecor_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDecor.SelectedItem.Text == "SELECIONE")
        {
            lblDecor.Text = "Selecione um valor";
        }
        else
        {
            try
            {
                lblDecor.Text = null;

                //preço da decoração
                DataView dvDecor = (DataView)sqlDecorEsc.Select(DataSourceSelectArguments.Empty);
                Session["precoAdcDecor"] = Convert.ToDouble(dvDecor.Table.Rows[0]["precoAdc_decor"].ToString());

                //calcular para mostrar
                double precoTam, precoAdcMassa, precoAdcCobertura, precoAdcDecor, preco3;
                precoTam = (double)Session["precoTam"];
                precoAdcMassa = (double)Session["precoAdcMassa"];
                precoAdcCobertura = (double)Session["precoAdcCobertura"];
                precoAdcDecor = (double)Session["precoAdcDecor"];
                preco3 = precoTam + precoAdcMassa + precoAdcCobertura + precoAdcDecor;
                lblPreco.Text = "R$" + preco3.ToString("#0.00");
                Session["preco"] = preco3;
            }
            catch
            {

            }
        }

    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
        if (ddlCobertura.SelectedItem.Text == "SELECIONE" || ddlCorCobertura.SelectedItem.Text == "SELECIONE" || ddlCorDecor.SelectedItem.Text == "SELECIONE" ||
                ddlCorMassa.SelectedItem.Text == "SELECIONE" || ddlDecor.SelectedItem.Text == "SELECIONE" || ddlFormato.SelectedItem.Text == "SELECIONE" ||
                ddlMassa.SelectedItem.Text == "SELECIONE" || ddlRecheio.SelectedItem.Text == "SELECIONE" || ddlSaborRecheio.SelectedItem.Text == "SELECIONE")
        {
            lblMsg.Text = "Selecione os devidos valores";
        }
        else
        {
                //preço
                double precoTam, precoAdcMassa, precoAdcCobertura, precoAdcDecor, precoTot;

                precoTam = (double)Session["precoTam"];
                precoAdcMassa = (double)Session["precoAdcMassa"];
                precoAdcCobertura = (double)Session["precoAdcCobertura"];
                precoAdcDecor = (double)Session["precoAdcDecor"];
                precoTot = precoTam + precoAdcMassa + precoAdcDecor + precoAdcCobertura;

                //insert
                sqlCadastrar.InsertParameters["PRECO"].DefaultValue = Convert.ToString(precoTot).Replace(',', '.');
                sqlCadastrar.Insert();

                //obter o id do produto recém cadastrado
                DataView dvIdProd = (DataView)sqlCadastrar.Select(DataSourceSelectArguments.Empty);

                Session["idProdC"] = dvIdProd.Table.Rows[0]["idMax"].ToString();

                //outros inserts
                sqlCadCorCob.Insert();
                sqlCadCorDecor.Insert();
                sqlCadCorMassa.Insert();
                sqlCadSaborRecheio.Insert();

                //limpar sessions
                Session["precoTam"] = "";
                Session["precoAdcMassa"] = "";
                Session["precoAdcCobertura"] = "";
                Session["precoAdcDecor"] = "";

                carrinho();
            
        }
    }

    public void carrinho()
    {
        //verificar se o cliente está logado
        if ((string)Session["tipoCli"] != null)
        {
            //verificar se é o primeiro item a ser adicionado ao carrinho
            if ((string)Session["novaCompra"] == "SIM")
            {
                //inserir na tabela pedidos
                DateTime dt = DateTime.Now.Date;
                String data = dt.ToString("yyyy/MM/dd");
                sqlInserirVenda.InsertParameters["DATA"].DefaultValue = data;
                sqlInserirVenda.Insert();

                Session["novaCompra"] = "NÃO";

                //obter o id do pedido recém-feito
                DataView dv = (DataView)sqlInserirVenda.Select(DataSourceSelectArguments.Empty);
                Session["idPedido"] = dv.Table.Rows[0]["idPedido"].ToString();
            }

            //preço
            double preco, qtdItens, total;
            preco = Convert.ToDouble(Session["preco"]);
            Session["preco"] = null;
            qtdItens = Convert.ToDouble(txtQtd.Text);

            total = preco * qtdItens;

            //inserir na tabela intermediária
            sqlInserirItens.InsertParameters["TOTAL"].DefaultValue = total.ToString().Replace(',', '.');
            sqlInserirItens.Insert();

            Response.Redirect("carrinho.aspx");

        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }

}