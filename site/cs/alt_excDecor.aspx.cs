using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class alt_excDecoracao : System.Web.UI.Page
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

    protected void ddlDecoracao_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDecoracao.SelectedItem.Text == "SELECIONE")
        {
            lblMsg.Text = "Selecione um valor";
        }
        else
        {
            DataView dv;
            dv = (DataView)sqlExibirDecoracao.Select(DataSourceSelectArguments.Empty);

            //carregar dados
            txtPreco.Text = dv.Table.Rows[0]["precoAdc_decor"].ToString();
            txtNome.Text = ddlDecoracao.SelectedItem.ToString();
            lblMsg.Text = string.Empty;
        }

    }

    protected void btnAlterar_Click(object sender, EventArgs e)
    {
        try
        {
            //update
            sqlExibirDecoracao.UpdateParameters["PRECOADC"].DefaultValue = txtPreco.Text.Replace(',', '.');
            sqlExibirDecoracao.Update();
            ddlDecoracao.DataBind();

            //limpar campos
            txtNome.Text = string.Empty;
            txtPreco.Text = string.Empty;
            ddlDecoracao.ClearSelection();
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
            sqlExibirDecoracao.Delete();
            ddlDecoracao.DataBind();

            //limpar campos
            txtNome.Text = string.Empty;
            txtPreco.Text = string.Empty;
            ddlDecoracao.ClearSelection();
            lblMsg.Text = "Dado excluído com sucesso.";
        }
        catch
        {
            lblMsg.Text = "Não foi possível excluir o dado.";
        }
    }
}