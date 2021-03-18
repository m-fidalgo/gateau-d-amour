using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class alt_excCobertura : System.Web.UI.Page
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

    protected void ddlFormato_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataView dv;
        dv = (DataView)sqlExibirCobertura.Select(DataSourceSelectArguments.Empty);

        //carregar campos
        txtPreco.Text = dv.Table.Rows[0]["precoAdc_cobertura"].ToString();
        txtNome.Text = ddlCobertura.SelectedItem.ToString();
        lblMsg.Text = string.Empty;
    }

    protected void btnAlterar_Click(object sender, EventArgs e)
    {
        try
        {
            //update
            sqlExibirCobertura.UpdateParameters["PRECOADC"].DefaultValue = txtPreco.Text.Replace(',', '.');
            sqlExibirCobertura.Update();
            ddlCobertura.DataBind();

            //limpar campos
            txtNome.Text = string.Empty;
            txtPreco.Text = string.Empty;
            ddlCobertura.ClearSelection();
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
            sqlExibirCobertura.Delete();
            ddlCobertura.DataBind();

            //limpar campos
            txtNome.Text = string.Empty;
            txtPreco.Text = string.Empty;
            ddlCobertura.ClearSelection();
            lblMsg.Text = "Dado excluído com sucesso.";
        }
        catch
        {
            lblMsg.Text = "Não foi possível excluir o dado.";
        }
    }
}