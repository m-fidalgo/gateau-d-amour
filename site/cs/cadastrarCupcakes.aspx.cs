using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class cadastrarCupcakes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((string)Session["tipoCli"] == null)
        {
            Response.Redirect("login.aspx");
        }
        else
        {
            if ((string)Session["tipoCli"] == "cli")
            {
                Response.Redirect("user.aspx");
            }
        }

        //gambiarra do file upload
        LinkButton1.Attributes.Add("onclick", "document.getElementById('" + fuImagem.ClientID + "').click(); return false;");
    }

    protected void ddlFormato_SelectedIndexChanged(object sender, EventArgs e)
    {
        //permitindo a escolha do tamanho
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

            //preço tamanho
            DataView dvTam = (DataView)sqlTamanhoEsc.Select(DataSourceSelectArguments.Empty);
            Session["precoTam"] = Convert.ToDouble(dvTam.Table.Rows[0]["preco_tamanho"].ToString());
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
            lblMassa.Text = null;

            //preço massa
            DataView dvMassa = (DataView)sqlMassaEsc.Select(DataSourceSelectArguments.Empty);
            Session["precoAdcMassa"] = Convert.ToDouble(dvMassa.Table.Rows[0]["precoAdc_massa"].ToString());
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
            lblCob.Text = null;

            //preço cobertura
            DataView dvCobertura = (DataView)sqlCoberturaEsc.Select(DataSourceSelectArguments.Empty);
            Session["precoAdcCobertura"] = Convert.ToDouble(dvCobertura.Table.Rows[0]["precoAdc_cobertura"].ToString());
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
            lblDecor.Text = null;

            //preço decoração
            DataView dvDecor = (DataView)sqlDecorEsc.Select(DataSourceSelectArguments.Empty);
            Session["precoAdcDecor"] = Convert.ToDouble(dvDecor.Table.Rows[0]["precoAdc_decor"].ToString());
        }
    }

    protected void btnPreco_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlCobertura.SelectedItem.Text == "SELECIONE" || ddlCorCobertura.SelectedItem.Text == "SELECIONE" || ddlCorDecor.SelectedItem.Text == "SELECIONE" ||
                ddlCorMassa.SelectedItem.Text == "SELECIONE" || ddlDecor.SelectedItem.Text == "SELECIONE" || ddlFormato.SelectedItem.Text == "SELECIONE" ||
                ddlGen.SelectedItem.Text == "SELECIONE" || ddlMassa.SelectedItem.Text == "SELECIONE" || ddlRecheio.SelectedItem.Text == "SELECIONE" ||
                ddlSaborRecheio.SelectedItem.Text == "SELECIONE")
            {
                lblMsg.Text = "Selecione os devidos valores";
            }
            else
            {
                //preço
                double precoTot, precoTam, precoMassa, precoCobertura, precoDecor;

                precoTam = (double)Session["precoTam"];
                precoMassa = (double)Session["precoAdcMassa"];
                precoCobertura = (double)Session["precoAdcCobertura"];
                precoDecor = (double)Session["precoAdcDecor"];
                precoTot = precoTam + precoMassa + precoCobertura + precoDecor;
                lblPreco.Text = precoTot.ToString("#0.00");

                //limpar campos
                lblMsg.Text = null;                 
            }
                       
        }
        catch
        {
            lblMsg.Text = "Erro no cálculo";
        }

    }

    protected void btnCadastrar_Click(object sender, EventArgs e)
    {
       try
        {
            if (ddlCobertura.SelectedItem.Text == "SELECIONE" || ddlCorCobertura.SelectedItem.Text == "SELECIONE" || ddlCorDecor.SelectedItem.Text == "SELECIONE" ||
                ddlCorMassa.SelectedItem.Text == "SELECIONE" || ddlDecor.SelectedItem.Text == "SELECIONE" || ddlFormato.SelectedItem.Text == "SELECIONE" ||
                ddlGen.SelectedItem.Text == "SELECIONE" || ddlMassa.SelectedItem.Text == "SELECIONE" || ddlRecheio.SelectedItem.Text == "SELECIONE" ||
                ddlSaborRecheio.SelectedItem.Text == "SELECIONE")
            {
                lblMsg.Text = "Selecione os devidos valores";
            }
            else
            {                
                //preço
                double precoTot, precoTam, precoMassa, precoCobertura, precoDecor;

                precoTam = (double)Session["precoTam"];
                precoMassa = (double)Session["precoAdcMassa"];
                precoCobertura = (double)Session["precoAdcCobertura"];
                precoDecor = (double)Session["precoAdcDecor"];
                precoTot = precoTam + precoMassa + precoCobertura + precoDecor;
                sqlCadastrar.InsertParameters["PRECO"].DefaultValue = precoTot.ToString();

                //imagem
                string img, nomeFoto;

                nomeFoto = fuImagem.FileName;

                if (nomeFoto != "")
                {
                    fuImagem.SaveAs(Server.MapPath("~\\imgs\\produtos\\" + nomeFoto));
                    img = nomeFoto;
                }
                else
                {
                    img = "noImg.png";
                }

                sqlCadastrar.InsertParameters["IMG"].DefaultValue = img;

                //insert
                sqlCadastrar.Insert();
                lblMsg.Text = "Produto cadastrado com sucesso";                
            }

        }
        catch
        {
            lblMsg.Text = "Não foi possível cadastrar o produto.";
        }
            
        

    }

    protected void sqlCadastrar_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        DataView dvIdProd = (DataView)sqlCadastrar.Select(DataSourceSelectArguments.Empty);

        Session["idProdC"] = dvIdProd.Table.Rows[0]["lastId"].ToString();

        //inserts
        sqlCadCorCobertura.Insert();
        sqlCadCorDecor.Insert();
        sqlCadCorMassa.Insert();
        sqlCadGenProd.Insert();
        sqlCadSaborRecheio.Insert();

        //limpar campos
        ddlCobertura.ClearSelection();
        ddlCorCobertura.ClearSelection();
        ddlCorDecor.ClearSelection();
        ddlCorMassa.ClearSelection();
        ddlDecor.ClearSelection();
        ddlFormato.ClearSelection();
        ddlGen.ClearSelection();
        ddlMassa.ClearSelection();
        ddlRecheio.ClearSelection();
        ddlSaborRecheio.ClearSelection();
        ddlTamanho.ClearSelection();
        ddlTamanho.Enabled = false;
        txtNome.Text = "";
        txtImg.Text = "";
        lblPreco.Text = "";
        Session["precoTam"] = null;
        Session["precoAdcMassa"] = null;
        Session["precoAdcDecor"] = null;
        Session["precoAdcCobertura"] = null;
        lblMsg.Text = "Produto cadastrado com sucesso.";
    }
}