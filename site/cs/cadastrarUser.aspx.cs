using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Net.Mail;
using System.Net;
using System.Security.Cryptography;

public partial class cadastrarUser : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("bblm");

    protected void Page_Load(object sender, EventArgs e)
    {

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

    protected void btnCadastrar_Click(object sender, EventArgs e)
    {
        if (ctrlGoogleReCaptcha.Validate())
        {
            ///gerador de senha
            int lengthOfPassword = 8;
            string passCode = DateTime.Now.Ticks.ToString();
            string pass = BitConverter.ToString(new System.Security.Cryptography.SHA512CryptoServiceProvider().ComputeHash(Encoding.Default.GetBytes(passCode))).Replace("-", String.Empty);
            string senha;
            senha = pass.Substring(0, lengthOfPassword);
            
            string email;
            email = txtEmail.Text;

            try
            { 

                ///insert
                DateTime data = Convert.ToDateTime(txtDataNasc.Text);
                String dataCorreta = data.ToString("yyyy/MM/dd");
                sqlCadastrarUser.InsertParameters["DATA"].DefaultValue = dataCorreta;
                sqlCadastrarUser.InsertParameters["EMAIL"].DefaultValue = cripto.Encrypt(txtEmail.Text);
                sqlCadastrarUser.InsertParameters["SENHA"].DefaultValue = cripto.Encrypt(senha);
                sqlCadastrarUser.InsertParameters["CPF"].DefaultValue = cripto.Encrypt(txtCPF.Text);
                sqlCadastrarUser.InsertParameters["RG"].DefaultValue = cripto.Encrypt(txtRG.Text);

                sqlCadastrarUser.Insert();

                ///email
                try
                {
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
                }
                catch
                {
                    lblErro.Text = "Não foi possível enviar o email";
                }
                

                Response.Redirect("irLogin.aspx");

            }
            catch
            {
                lblErro.Text = "Tente novamente";
            }
                  
        }
        else
        {
            lblErro.Text = "Tente novamente";
        }
                   
    }
}