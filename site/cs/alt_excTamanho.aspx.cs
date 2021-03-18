using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class alt_excTamanho : System.Web.UI.Page
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
    }

    protected void ddlCategoria_SelectedIndexChanged(object sender, EventArgs e)
    {
        //limpar campos
        txtDesc.Text = string.Empty;
        txtMedidas.Text = string.Empty;
        txtPreco.Text = string.Empty;
        ddlFormato.ClearSelection();
        ddlTamanho.ClearSelection();
        ddlTamanho.Enabled = false;
        lblMsg.Text = string.Empty;

        //permitir a escolha do formato
        ddlFormato.Enabled = true;
    }

    protected void ddlFormato_SelectedIndexChanged(object sender, EventArgs e)
    {
        //permitir a escolha do tamanho
        if(ddlFormato.SelectedItem.Text == "SELECIONE"){
            ddlTamanho.Enabled = false;
            lblMsg.Text = "Selecione um valor";
        }
        else
        {
            ddlTamanho.Enabled = true;
            lblMsg.Text = "";

        }

    }

    protected void ddlTamanho_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(ddlTamanho.SelectedItem.Text == "SELECIONE")
        {
            lblMsg.Text = "Selecione um valor";
        }
        else
        {
            //carregar 
            DataView dvTam = (DataView)sqlExibirTamanho.Select(DataSourceSelectArguments.Empty);

            txtDesc.Text = dvTam.Table.Rows[0]["descr_tamanho"].ToString();
            txtMedidas.Text = dvTam.Table.Rows[0]["medidas_tamanho"].ToString(); ;

            double preco;
            preco = Convert.ToDouble(dvTam.Table.Rows[0]["preco_tamanho"].ToString());
            txtPreco.Text = preco.ToString("#0.00");
            lblMsg.Text = "";
        }
        
    }

    protected void btnAlterar_Click(object sender, EventArgs e)
    {
        try
        {
            //update
            sqlExibirTamanho.UpdateParameters["PRECO"].DefaultValue = txtPreco.Text.Replace(',', '.');
            sqlExibirTamanho.Update();
            ddlCategoria.DataBind();
            ddlFormato.DataBind();
            ddlTamanho.DataBind();

            //limpar campos
            txtDesc.Text = string.Empty;
            txtMedidas.Text = string.Empty;
            txtPreco.Text = string.Empty;
            ddlCategoria.ClearSelection();
            ddlFormato.ClearSelection();
            ddlTamanho.ClearSelection();
            ddlTamanho.Enabled = false;
            ddlFormato.Enabled = false;
            lblMsg.Text = "Dado alterado com sucesso.";
        }
        catch
        {
            lblMsg.Text = "Não foi possível alterar o dado.";
        }
    }

    protected void btnExcluir_Click(object sender, EventArgs e)
    {
        try
        {
            //delete
            sqlExibirTamanho.Delete();
            ddlCategoria.DataBind();
            ddlFormato.DataBind();
            ddlTamanho.DataBind();

            //limpar campos
            txtDesc.Text = string.Empty;
            txtMedidas.Text = string.Empty;
            txtPreco.Text = string.Empty;
            ddlCategoria.ClearSelection();
            ddlFormato.ClearSelection();
            ddlTamanho.ClearSelection();
            ddlTamanho.Enabled = false;
            ddlFormato.Enabled = false;
            lblMsg.Text = "Dado excluído com sucesso.";
        }
        catch
        {
            lblMsg.Text = "Não foi possível excluir o dado.";
        }
    }

    
}