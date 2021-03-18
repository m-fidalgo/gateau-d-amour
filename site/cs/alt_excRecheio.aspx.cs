using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class alt_excRecheio : System.Web.UI.Page
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

    protected void ddlRecheio_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(ddlRecheio.SelectedItem.Text == "SELECIONE")
        {
            lblMsg.Text = "Selecione um valor";
        }
        else
        {
            txtNome.Text = ddlRecheio.SelectedItem.ToString();
            lblMsg.Text = string.Empty;
        }
        
    }

    protected void btnAlterar_Click(object sender, EventArgs e)
    {
        try
        {
            //update
            sqlExibirRecheio.Update();
            ddlRecheio.DataBind();

            //limpar campos
            txtNome.Text = string.Empty;
            ddlRecheio.ClearSelection();
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
            sqlExibirRecheio.Delete();
            ddlRecheio.DataBind();

            //limpar campos
            txtNome.Text = string.Empty;
            ddlRecheio.ClearSelection();
            lblMsg.Text = "Dado excluído com sucesso.";
        }
        catch
        {
            lblMsg.Text = "Não foi possível excluir o dado.";
        }
    }
}