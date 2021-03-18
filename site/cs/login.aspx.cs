using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class login : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("bblm");
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((string)Session["tipoCli"] != null)
        {
            Response.Redirect("user.aspx");
        }

        if (Session["i"] == null)
        {
            Response.Redirect("index.aspx");
        }

        lblErro.Text = string.Empty;
    }

    //recaptcha
    GoogleReCaptcha.GoogleReCaptcha ctrlGoogleReCaptcha = new GoogleReCaptcha.GoogleReCaptcha();
    protected override void CreateChildControls()
    {
        base.CreateChildControls();
        ctrlGoogleReCaptcha.PublicKey = "6Le_x2kUAAAAAL0sJaarasZVzVI7Ru_cXi7p-bLN";
        ctrlGoogleReCaptcha.PrivateKey = "6Le_x2kUAAAAACfhJI9m3r3doSiiaqaf0ESgc6I1";
        this.Panel1.Controls.Add(ctrlGoogleReCaptcha);       
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        int i = Convert.ToInt32((int)Session["i"]);

        try
        {
            //ver se o usuário existe
            DataView dvLogin;
            sqlLogin.SelectParameters["EMAIL"].DefaultValue = cripto.Encrypt(txtEmail.Text);
            sqlLogin.SelectParameters["SENHA"].DefaultValue = cripto.Encrypt(txtSenha.Text);

            dvLogin = (DataView)sqlLogin.Select(DataSourceSelectArguments.Empty);
            String loginCli = dvLogin.Table.Rows[0]["login_cli"].ToString();
                 
            //se o recaptcha está visível - o usuário já errou login/senha mais de 3 vezes
            if(ctrlGoogleReCaptcha.Visible == true)
            {
                //se o usuário passa na validação do recaptcha
                if (ctrlGoogleReCaptcha.Validate())
                {
                    Session["tipoCli"] = dvLogin.Table.Rows[0]["tipo_cli"].ToString();
                    Session["nomeCli"] = dvLogin.Table.Rows[0]["nome_cli"].ToString();
                    Session["idCli"] = dvLogin.Table.Rows[0]["id_cli"].ToString();
                    
                    Response.Redirect("respostaUser.aspx");
                }
                else
                {
                    lblErro.Text = "Tente novamente";
                }
            }
            else
            {

                Session["tipoCli"] = dvLogin.Table.Rows[0]["tipo_cli"].ToString();
                Session["nomeCli"] = dvLogin.Table.Rows[0]["nome_cli"].ToString();
                Session["idCli"] = dvLogin.Table.Rows[0]["id_cli"].ToString();

                //se é o 1º login do usuário
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
            //se o usuário não existe
            lblErro.Text = "Email ou senha incorretos";
            txtEmail.Text = string.Empty;
            txtSenha.Text = string.Empty;

            i++;           
            Session["i"] = i;

            //se as informações dadas não forem válidas três vezes consecutivas
            if (i >= 3)
            {
                ctrlGoogleReCaptcha.Visible = true;
                Panel1.Visible = true;
            }
        }
    }
}