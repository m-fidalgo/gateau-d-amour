using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class alt_excCor : System.Web.UI.Page
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

    protected void ddlCor_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(ddlCor.SelectedItem.Text == "SELECIONE")
        {
            lblMsg.Text = "Selecione um valor";
        }
        else
        {
            txtNome.Text = ddlCor.SelectedItem.ToString();
            lblMsg.Text = string.Empty;
        }
        
    }

    protected void btnAlterar_Click(object sender, EventArgs e)
    {
        try
        {
            //update
            sqlExibirCor.Update();
            ddlCor.DataBind();

            //limpar campos
            txtNome.Text = string.Empty;
            ddlCor.ClearSelection();
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
            sqlExibirCor.Delete();
            ddlCor.DataBind();

            //limpar campos
            txtNome.Text = string.Empty;
            ddlCor.ClearSelection();
            lblMsg.Text = "Dado excluído com sucesso.";
        }
        catch
        {
            lblMsg.Text = "Não foi possível excluir o dado.";
        }
    }
}