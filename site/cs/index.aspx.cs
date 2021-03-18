using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;
using System.Text;

public partial class index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["i"] = 0;
    }

    protected void btnEnviar_Click(object sender, EventArgs e)
    {
        try
        { 
            //email
            MailMessage objEmail = new MailMessage();
            objEmail.From = new MailAddress("gateau.d.amour.tcc@outlook.com");
            objEmail.To.Add("gateau.d.amour.tcc@outlook.com");
            objEmail.Subject = txtAssunto.Text;
            objEmail.Body = "Email do Cliente:" + txtEmail.Text + "\r\n" + "Nome do Cliente:" + txtNome.Text + "\r\n" + "Mensagem:" + txtMensagem.Text;
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

            //limpar campos
            lblMsg.Text = "Email enviado com sucesso.";            
            txtEmail.Text = string.Empty;
            txtNome.Text = string.Empty;
            txtAssunto.Text = string.Empty;
            txtMensagem.Text = string.Empty;
        }
        catch
        {            
            lblMsg.Text = "Não foi possível enviar o email.";
            txtEmail.Text = string.Empty;
            txtNome.Text = string.Empty;
            txtAssunto.Text = string.Empty;
            txtMensagem.Text = string.Empty;
        }

        
        
    }
}