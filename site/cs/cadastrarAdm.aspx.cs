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


public partial class cadastrarAdm : System.Web.UI.Page
{

    Criptografia cripto = new Criptografia("bblm");

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

    //recaptcha
    GoogleReCaptcha.GoogleReCaptcha ctrlGoogleReCaptcha = new GoogleReCaptcha.GoogleReCaptcha();
    protected override void CreateChildControls()
    {
        base.CreateChildControls();
        ctrlGoogleReCaptcha.PublicKey = "6Le_x2kUAAAAAL0sJaarasZVzVI7Ru_cXi7p-bLN";
        ctrlGoogleReCaptcha.PrivateKey = "6Le_x2kUAAAAACfhJI9m3r3doSiiaqaf0ESgc6I1";
        this.Panel1.Controls.Add(ctrlGoogleReCaptcha);
    }

    protected void btnCadastrarAdm_Click(object sender, EventArgs e)
    {
        if (ctrlGoogleReCaptcha.Validate())
        {
            ///gerador da senha
            int lengthOfPassword = 8;
            string passCode = DateTime.Now.Ticks.ToString();
            string pass = BitConverter.ToString(new System.Security.Cryptography.SHA512CryptoServiceProvider().ComputeHash(Encoding.Default.GetBytes(passCode))).Replace("-", String.Empty);
            string senha;
            senha = pass.Substring(0, lengthOfPassword);
           
            string email;
            email = txtEmailAdm.Text;

            try
            {
                //insert
                DateTime dt = Convert.ToDateTime(txtDtNascAdm.Text);
                String DataCorreta = dt.ToString("yyyy/MM/dd");
                sqlCadastrarAdm.InsertParameters["DTNASC"].DefaultValue = DataCorreta;
                sqlCadastrarAdm.InsertParameters["EMAIL"].DefaultValue = cripto.Encrypt(txtEmailAdm.Text);
                sqlCadastrarAdm.InsertParameters["SENHA"].DefaultValue = cripto.Encrypt(senha);
                sqlCadastrarAdm.InsertParameters["CPF"].DefaultValue = cripto.Encrypt(txtCpfAdm.Text);
                sqlCadastrarAdm.InsertParameters["RG"].DefaultValue = cripto.Encrypt(txtRgAdm.Text);

                sqlCadastrarAdm.Insert();

                ///email
                MailMessage objEmail = new MailMessage();
                objEmail.From = new MailAddress("gda.contato@outlook.com");
                objEmail.To.Add(email);
                objEmail.Subject = "Senha - Gâteau d'Amour";
                objEmail.Body = "Olá! Obrigado por ter se cadastrado na Gâteau d'Amour! Sua senha é " + senha + "\r\n" + "Favor alterar sua senha após o primeiro login.";
                objEmail.SubjectEncoding = Encoding.GetEncoding("ISO-8859-1");
                objEmail.BodyEncoding = Encoding.GetEncoding("ISO-8859-1");
                NetworkCredential netCred = new NetworkCredential("gda.contato@outlook.com", "senha123");
                SmtpClient objSmtp = new SmtpClient();
                objSmtp.Host = "smtp.live.com";
                objSmtp.Port = 587;
                objSmtp.EnableSsl = true;
                objSmtp.Credentials = netCred;
                objSmtp.Send(objEmail);
                objSmtp.Dispose();

                //limpar campos
                txtCpfAdm.Text = "";
                txtDtNascAdm.Text = "";
                txtEmailAdm.Text = "";
                txtNomeAdm.Text = "";
                txtRgAdm.Text = "";
                txtSobrenomeAdm.Text = "";
                txtTelefone2Adm.Text = "";
                txtTelefoneAdm.Text = "";
                txtResp.Text = "";

                lblMensagem.Text = "Usuário cadastrado com sucesso!";

            }
            catch (FormatException)
            {
                lblMensagem.Text = "O email inserido não é válido";
            }
            catch (SmtpException)
            {
                lblMensagem.Text = "O email inserido não é válido";
            }
            catch (DuplicateNameException)
            {
                lblMensagem.Text = "Esse email ou CPF já está sendo utilizado";
            }
            catch (NullReferenceException)
            {
                lblMensagem.Text = "Tente novamente";
            }
        }
        else
        {
            lblMensagem.Text = "Tente novamente";
        }
    }
}