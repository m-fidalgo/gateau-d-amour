using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class cadastrarTamanho : System.Web.UI.Page
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
            if(ddlFormato.SelectedItem.Text == "SELECIONE")
            {
                lbl1.Text = "Selecione um valor";
            }
            else
            {                
                //insert
                sqlCadastrarTamanho.InsertParameters["PRECO"].DefaultValue = txtPreco.Text.Replace(',', '.');
                sqlCadastrarTamanho.Insert();

                //limpar campos
                lbl1.Text = null;
                txtDesc.Text = string.Empty;
                txtMedidas.Text = string.Empty;
                txtPreco.Text = string.Empty;
                ddlFormato.ClearSelection();
                lblMsg.Text = "Dado cadastrado com sucesso.";
            }            
        }
        catch
        {
            lblMsg.Text = "Não foi possível cadastrar o dado.";
        }
    }
}