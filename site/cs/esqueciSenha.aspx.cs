using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Net.Mail;
using System.Net;
using System.Data;

public partial class esqueciSenha : System.Web.UI.Page
{

    Criptografia cripto = new Criptografia("bblm");

    protected void Page_Load(object sender, EventArgs e)
    {
        if ((string)Session["tipoCli"] != null)
        {
            Response.Redirect("user.aspx");
        }
        
    }

    protected void btnEnviar_Click(object sender, EventArgs e)
    {
        // try
        //{
            //verificando se o email digitado existe
            sqlSenha.SelectParameters["EMAIL"].DefaultValue = cripto.Encrypt(txtEmail.Text);
            DataView dv = (DataView)sqlSenha.Select(DataSourceSelectArguments.Empty);

            if (dv.Table.Rows.Count != 0)
            {
                ///gerador de senha
                int lengthOfPassword = 8;
                string passCode = DateTime.Now.Ticks.ToString();
                string pass = BitConverter.ToString(new System.Security.Cryptography.SHA512CryptoServiceProvider().ComputeHash(Encoding.Default.GetBytes(passCode))).Replace("-", String.Empty);
                string senha;
                senha = pass.Substring(0, lengthOfPassword);

                //update - mudar a senha                
                sqlSenha.UpdateParameters["EMAIL"].DefaultValue = cripto.Encrypt(txtEmail.Text);
                sqlSenha.UpdateParameters["SENHA"].DefaultValue = cripto.Encrypt(senha);
                sqlSenha.Update();

                string email;
                email = txtEmail.Text;

                ///email
                MailMessage objEmail = new MailMessage();
                objEmail.From = new MailAddress("gateau.d.amour.tcc@outlook.com");
                objEmail.To.Add(email);
                objEmail.Subject = "Senha - Gâteau d'Amour";
                objEmail.Body = "Olá! Obrigado por ter se cadastrado na Gâteau d'Amour! Sua senha é " + senha + "\r\n" + "Favor alterar sua senha após o primeiro login.";
                objEmail.SubjectEncoding = Encoding.GetEncoding("ISO-8859-1");
                objEmail.BodyEncoding = Encoding.GetEncoding("ISO-8859-1");
                NetworkCredential netCred = new NetworkCredential("gateau.d.amour.tcc@outlook.com", "tccbblm2018");
                SmtpClient objSmtp = new SmtpClient();
                objSmtp.Host = "smtp.live.com";
                objSmtp.Port = 587;
                objSmtp.EnableSsl = true;
                objSmtp.Credentials = netCred;
                objSmtp.Send(objEmail);
                objSmtp.Dispose();           

                

                Response.Redirect("irLogin.aspx");
            }
            else
            {
                lblMsg.Text = "O email inserido não é válido";
            }
        //}

        //catch
       // {
         //   lblMsg.Text = "Tente Novamente";
       // }
    }
}