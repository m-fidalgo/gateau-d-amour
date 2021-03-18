using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class alterarSenha : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("bblm");
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((string)Session["tipoCli"] == null)
        {
            Response.Redirect("login.aspx");
        }
    }

    protected void btnForca_Click(object sender, EventArgs e)
    {
        int qtdLetras;
        int qtdLetMai = 0, qtdLetMin = 0, qtdNum = 0, qtdCar = 0;

        qtdLetras = txtSenha.Text.Length;

        //quantidade de caracteres
        if (qtdLetras < 6)
        {
            lblForca.Text = "Favor digitar uma senha com, no mínimo, 6 caracteres";
            txtConfSenha.Text = null;
            txtSenha.Text = null;
        }
        else
        {
            txtSenha.Attributes.Add("value", txtSenha.Text);
            lblForca.Text = "Senha Fraca";

            for (int i = 0; i < qtdLetras; i++)
            {
                //se tem caracteres minúsculos
                if (char.IsLower(txtSenha.Text[i]))
                {
                    qtdLetMin++;
                }
                else
                {
                    //se tem caracteres maiúsculos
                    if (char.IsUpper(txtSenha.Text[i]))
                    {
                        qtdLetMai = qtdLetMai + 1;
                    }
                    else
                    {
                        //se tem números
                        if (char.IsNumber(txtSenha.Text[i]))
                        {
                            qtdNum++;
                        }
                        else
                        {
                            //se tem outros tipos de caracteres
                            if (!char.IsWhiteSpace(txtSenha.Text[i]))
                            {
                                qtdCar++;
                            }
                        }
                    }
                }
            }

            if (qtdCar != 0 &&
                qtdLetMai != 0 &&
                qtdLetMin != 0 &&
                qtdNum != 0)
            {
                lblForca.Text = "Senha Forte";
            }
            else
            {
                if (qtdCar != 0)
                {
                    if (qtdLetMai != 0 && qtdLetMin != 0)
                    {
                        lblForca.Text = "Senha Média";
                    }
                    if (qtdLetMai != 0 && qtdNum != 0)
                    {
                        lblForca.Text = "Senha Média";
                    }
                    if (qtdLetMin != 0 && qtdNum != 0)
                    {
                        lblForca.Text = "Senha Média";
                    }
                }
                else
                {
                    if (qtdLetMai != 0)
                    {
                        if (qtdLetMin != 0 && qtdNum != 0)
                        {
                            lblForca.Text = "Senha Média";
                        }
                    }
                    else
                    {
                        lblForca.Text = "Senha Fraca";
                    }

                }
            }
        }
    }


    protected void btnAlterar_Click(object sender, EventArgs e)
    {
        String senha, conf_senha;

        senha = txtSenha.Text;
        conf_senha = txtConfSenha.Text;

        if (txtSenha.Text != "")
        {
            int qtdLetras = txtSenha.Text.Length;

            //verificar a quantidade de caracteres da senha
            if (qtdLetras < 6)
            {
                lblForca.Text = "Favor digitar uma senha com, no mínimo, 6 caracteres";
                txtConfSenha.Text = null;
                txtSenha.Text = null;
            }
            else
            {
                //verificar se as duas senhas são iguais
                if (senha == conf_senha)
                {
                    //update
                    sqlAltSenha.UpdateParameters["SENHA"].DefaultValue = cripto.Encrypt(txtSenha.Text);
                    sqlAltSenha.Update();
                    Response.Redirect("user.aspx");
                }
                else
                {
                    txtConfSenha.Text = null;
                    txtSenha.Text = null;
                    lblForca.Text = "As senhas não estão iguais";
                }
            }                       
        }
        else
        {
            lblForca.Text = "Favor digitar uma senha com, no mínimo, 6 caracteres";
        }

    }
}