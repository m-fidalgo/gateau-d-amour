using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class respostaUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((string)Session["tipoCli"] == null)
        {
            Response.Redirect("login.aspx");
        }
        else
        {
            if ((string)Session["tipoCli"] == "adm")
            {
                Response.Redirect("pgAdm.aspx");
            }            
        }
    }

    protected void btn_Click(object sender, EventArgs e)
    {
        try
        {
            //verificando a resposta
            DataView dv = (DataView)sqlResp.Select(DataSourceSelectArguments.Empty);
            String loginCli = dv.Table.Rows[0]["login_cli"].ToString();
            
            if(dv.Table.Rows.Count == 0)
            {
                lblErro.Text = "Resposta incorreta";
            }
            else
            {
                //se é o 1º login
                if(loginCli == "1")
                {
                    Response.Redirect("alterarSenha.aspx");
                }
                else
                {
                    Response.Redirect("user.aspx");
                }               
                
            }
        }
        catch
        {

        }
    }
}