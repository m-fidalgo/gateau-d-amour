using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class alt_excBolos : System.Web.UI.Page
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

    protected void ddlBolos_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlBolos.SelectedItem.Text == "SELECIONE")
        {
            lbl1.Text = "Selecione um valor";
        }
        else
        {
            DataView dvBolos = (DataView)sqlBolos.Select(DataSourceSelectArguments.Empty);

            //carregando a página
            txtNome.Text = dvBolos.Table.Rows[0]["nome_prod"].ToString();
            txtCamadas.Text = dvBolos.Table.Rows[0]["camadas_bolo"].ToString();
            txtAndares.Text = dvBolos.Table.Rows[0]["andares_bolo"].ToString();
            lblTamanho.Text = dvBolos.Table.Rows[0]["descr_tamanho"].ToString();
            lblGen.Text = dvBolos.Table.Rows[0]["nome_genero"].ToString();
            lblFormato.Text = dvBolos.Table.Rows[0]["descr_formato"].ToString();
            lblMassa.Text = dvBolos.Table.Rows[0]["nome_massa"].ToString();
            lblCorMassa.Text = dvBolos.Table.Rows[0]["corMassa"].ToString();
            lblCobertura.Text = dvBolos.Table.Rows[0]["nome_cobertura"].ToString();
            lblCorCobertura.Text = dvBolos.Table.Rows[0]["corCobertura"].ToString();
            lblDecor.Text = dvBolos.Table.Rows[0]["descr_decor"].ToString();
            lblCorDecor.Text = dvBolos.Table.Rows[0]["corDecor"].ToString();
            lblRecheio.Text = dvBolos.Table.Rows[0]["nome_recheio"].ToString();
            lblSaborRecheio.Text = dvBolos.Table.Rows[0]["desc_sabor"].ToString();
            imgBolo.Visible = true;
            imgBolo.ImageUrl = "~\\imgs\\produtos\\" + dvBolos.Table.Rows[0]["imagem"].ToString();

            //limpar campos
            lblMsg.Text = null;
            lbl1.Text = null;
            lbl1Cob.Text = null;
            lbl1Decor.Text = null;
            lbl1Formato.Text = null;
            lbl1Massa.Text = null;
            lbl1Tam.Text = null;
        }
        
    }

    protected void ddlFormato_SelectedIndexChanged(object sender, EventArgs e)
    {
        //permitir a escolha do tamanho
        if(ddlFormato.SelectedItem.Text == "SELECIONE")
        {
            lbl1Formato.Text = "Selecione um valor";
            ddlTamanho.Enabled = false;
        }
        else
        {
            ddlTamanho.Enabled = true;
            lbl1Formato.Text = null;
        }
        
    }

    protected void ddlTamanho_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlTamanho.SelectedItem.Text == "SELECIONE")
        {
            lbl1Tam.Text = "Selecione um valor";
        }
        else
        {
            lbl1Tam.Text = null;

            //pegar o preço do tamanho
            DataView dvTam = (DataView)sqlTamanhoEsc.Select(DataSourceSelectArguments.Empty);
            Session["precoTam"] = Convert.ToDouble(dvTam.Table.Rows[0]["preco_tamanho"].ToString());
        }
    }

    protected void ddlMassa_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlMassa.SelectedItem.Text == "SELECIONE")
        {
            lbl1Massa.Text = "Selecione um valor";
        }
        else
        {
            lbl1Massa.Text = null;

            //pegar o preço da massa
            DataView dvMassa = (DataView)sqlMassaEsc.Select(DataSourceSelectArguments.Empty);
            Session["precoAdcMassa"] = Convert.ToDouble(dvMassa.Table.Rows[0]["precoAdc_massa"].ToString());
        }
    }

    protected void ddlCobertura_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCobertura.SelectedItem.Text == "SELECIONE")
        {
            lbl1Cob.Text = "Selecione um valor";
        }
        else
        {
            lbl1Cob.Text = null;

            //pegar o preço da cobertura
            DataView dvCobertura = (DataView)sqlCoberturaEsc.Select(DataSourceSelectArguments.Empty);
            Session["precoAdcCobertura"] = Convert.ToDouble(dvCobertura.Table.Rows[0]["precoAdc_cobertura"].ToString());
        }
    }

    protected void ddlDecor_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDecor.SelectedItem.Text == "SELECIONE")
        {
            lbl1Decor.Text = "Selecione um valor";
        }
        else
        {
            lbl1Decor.Text = null;

            //pegar o preço da decoração
            DataView dvDecor = (DataView)sqlDecorEsc.Select(DataSourceSelectArguments.Empty);
            Session["precoAdcDecor"] = Convert.ToDouble(dvDecor.Table.Rows[0]["precoAdc_decor"].ToString());
        }
    }


    protected void btnAlterar_Click(object sender, EventArgs e)
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

                sqlAltProd.UpdateParameters["PRECO"].DefaultValue = precoTot.ToString();
                
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

                sqlAltProd.UpdateParameters["IMG"].DefaultValue = img;

                //updates
                sqlAltProd.Update();
                sqlAltCorCob.Update();
                sqlAltCorDecor.Update();
                sqlAltCorMassa.Update();
                sqlAltGenProd.Update();
                sqlAltSabor.Update();

                //limpar campos
                lblCobertura.Text = "";
                lblCorCobertura.Text = "";
                lblCorDecor.Text = "";
                lblCorMassa.Text = "";
                lblDecor.Text = "";
                lblFormato.Text = "";
                lblGen.Text = "";
                lblMassa.Text = "";
                lblRecheio.Text = "";
                lblSaborRecheio.Text = "";
                lblTamanho.Text = "";
                ddlBolos.ClearSelection();
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
                txtAndares.Text = "";
                txtCamadas.Text = "";
                txtImg.Text = "";
                txtNome.Text = "";
                imgBolo.ImageUrl = "";
                Session["precoTam"] = null;
                Session["precoAdcMassa"] = null;
                Session["precoAdcDecor"] = null;
                Session["precoAdcCobertura"] = null;
                lblMsg.Text = "Produto alterado com sucesso.";
                ddlBolos.DataBind();
            }            
        }
        catch
        {
            lblMsg.Text = "Não foi possível alterar o produto.";
        }
    }

    protected void btnExcluir_Click(object sender, EventArgs e)
    {
       
        try
        {
            sqlAltProd.Delete();

            //limpar campos
            lblCobertura.Text = "";
            lblCorCobertura.Text = "";
            lblCorDecor.Text = "";
            lblCorMassa.Text = "";
            lblDecor.Text = "";
            lblFormato.Text = "";
            lblGen.Text = "";
            lblMassa.Text = "";
            lblRecheio.Text = "";
            lblSaborRecheio.Text = "";
            lblTamanho.Text = "";
            ddlBolos.ClearSelection();
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
            txtAndares.Text = "";
            txtCamadas.Text = "";
            txtImg.Text = "";
            txtNome.Text = "";
            ddlBolos.DataBind();
            Session["precoTam"] = null;
            Session["precoAdcMassa"] = null;
            Session["precoAdcDecor"] = null;
            Session["precoAdcCobertura"] = null;
            lblMsg.Text = null;
            lbl1.Text = null;
            lbl1Cob.Text = null;
            lbl1Decor.Text = null;
            lbl1Formato.Text = null;
            lbl1Massa.Text = null;
            lbl1Tam.Text = null;
            lblMsg.Text = "Produto excluído com sucesso.";
        }
        catch
        {
            lblMsg.Text = "Não foi possível excluir o produto.";
        }
    }    
}