using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class cadastrarMassa : System.Web.UI.Page
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

    protected void btnCadastrar_Click(object sender, EventArgs e)
    {
        try
        {
            //insert
            sqlCadastrarMassa.InsertParameters["PRECOADC"].DefaultValue = txtPrecADC.Text.Replace(',', '.');
            sqlCadastrarMassa.Insert();

            //limpar campos
            txtNome.Text = string.Empty;
            txtPrecADC.Text = string.Empty;
            lblMsg.Text = "Dado cadastrado com sucesso.";
        }
        catch
        {
            lblMsg.Text = "Não foi possível cadastrar o dado.";
        }
    }
}