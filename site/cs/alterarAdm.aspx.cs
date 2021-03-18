using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class alterarAdm : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("bblm");

    protected void Page_Load(object sender, EventArgs e)
    {
        //carregar itens
        DataView dvUser = (DataView)sqlPesquisar.Select(DataSourceSelectArguments.Empty);

        lblNome.Text = dvUser.Table.Rows[0]["nome_cli"].ToString();
        lblSobrenome.Text = dvUser.Table.Rows[0]["sobrenome_cli"].ToString();
        lblTelefone1.Text = dvUser.Table.Rows[0]["tel1_cli"].ToString();
        lblTelefone2.Text = dvUser.Table.Rows[0]["tel2_cli"].ToString();
        lblCpf.Text = cripto.Decrypt(dvUser.Table.Rows[0]["cpf_cli"].ToString());
        lblEmail.Text = cripto.Decrypt(dvUser.Table.Rows[0]["email_cli"].ToString());
        lblRg.Text = cripto.Decrypt(dvUser.Table.Rows[0]["rg_cli"].ToString());
        DateTime dt = Convert.ToDateTime(dvUser.Table.Rows[0]["dataNasc_cli"].ToString());
        lblDtNasc.Text = dt.ToShortDateString();
        lblMsg.Text = string.Empty;
    }

    protected void btnSair_Click(object sender, EventArgs e)
    {
        Response.Redirect("pgAdm.aspx");
    }

    protected void btnForca_Click(object sender, EventArgs e)
    {
        int qtdLetras;
        int qtdLetMai = 0, qtdLetMin = 0, qtdNum = 0, qtdCar = 0;

        qtdLetras = txtSenha.Text.Length;

        //verificar número de caracteres
        if (qtdLetras < 6)
        {
            lblForca.Text = "Favor digitar uma senha com, no mínimo, 8 caracteres";
            txtConfSenha.Text = null;
            txtSenha.Text = null;
        }
        else
        {
            txtSenha.Attributes.Add("value", txtSenha.Text);
            lblForca.Text = "Senha Fraca";

            for (int i = 0; i < qtdLetras; i++)
            {
                //se tem caracter minúsculo
                if (char.IsLower(txtSenha.Text[i]))
                {
                    qtdLetMin++;
                }
                else
                {
                    //se tem caracter maiúsculo
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
                            //se é outro tipo de caracter
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

            //conferir a quantidade de caracteres da senha
            if (qtdLetras < 6)
            {
                lblForca.Text = "Favor digitar uma senha com, no mínimo, 6 caracteres";
                txtConfSenha.Text = null;
                txtSenha.Text = null;
            }
            else
            {
                //conferir se as duas senhas são iguais
                if (senha == conf_senha)
                {
                    //EMAIL
                    if (txtEmail.Text == "")
                    {
                        sqlAltPerfil.UpdateParameters["EMAIL"].DefaultValue = cripto.Encrypt(lblEmail.Text);
                    }
                    else
                    {
                        sqlAltPerfil.UpdateParameters["EMAIL"].DefaultValue = cripto.Encrypt(txtEmail.Text);
                    }

                    //TELEFONE 1
                    if (txtTel1.Text == "")
                    {
                        sqlAltPerfil.UpdateParameters["TELEFONE1"].DefaultValue = lblTelefone1.Text;
                    }
                    else
                    {
                        sqlAltPerfil.UpdateParameters["TELEFONE1"].DefaultValue = txtTel1.Text;
                    }

                    //update
                    sqlAltSenha.UpdateParameters["SENHA"].DefaultValue = cripto.Encrypt(txtSenha.Text);
                    sqlAltSenha.Update();
                    sqlAltPerfil.Update();

                    //limpar campos
                    txtConfSenha.Text = "";
                    txtEmail.Text = "";
                    txtSenha.Text = "";
                    txtTel1.Text = "";
                    txtTel2.Text = "";
                    lblMsg.Text = "Dado(s) alterado(s) com sucesso!";

                    //atualizar campos
                    DataView dvUser = (DataView)sqlPesquisar.Select(DataSourceSelectArguments.Empty);

                    lblTelefone1.Text = dvUser.Table.Rows[0]["tel1_cli"].ToString();
                    lblTelefone2.Text = dvUser.Table.Rows[0]["tel2_cli"].ToString();
                    lblEmail.Text = cripto.Decrypt(dvUser.Table.Rows[0]["email_cli"].ToString());
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
            //EMAIL
            if (txtEmail.Text == "")
            {
                sqlAltPerfil.UpdateParameters["EMAIL"].DefaultValue = cripto.Encrypt(lblEmail.Text);
            }
            else
            {
                sqlAltPerfil.UpdateParameters["EMAIL"].DefaultValue = cripto.Encrypt(txtEmail.Text);
            }

            //TELEFONE 1
            if (txtTel1.Text == "")
            {
                sqlAltPerfil.UpdateParameters["TELEFONE1"].DefaultValue = lblTelefone1.Text;
            }
            else
            {
                sqlAltPerfil.UpdateParameters["TELEFONE1"].DefaultValue = txtTel1.Text;
            }

            //update
            sqlAltPerfil.Update();

            //limpar campos
            txtConfSenha.Text = "";
            txtEmail.Text = "";
            txtSenha.Text = "";
            txtTel1.Text = "";
            txtTel2.Text = "";
            lblMsg.Text = "Dado(s) alterado(s) com sucesso!";

            //atualizar campos
            DataView dvUser = (DataView)sqlPesquisar.Select(DataSourceSelectArguments.Empty);

            lblTelefone1.Text = dvUser.Table.Rows[0]["tel1_cli"].ToString();
            lblTelefone2.Text = dvUser.Table.Rows[0]["tel2_cli"].ToString();
            lblEmail.Text = cripto.Decrypt(dvUser.Table.Rows[0]["email_cli"].ToString());

        }
    }
}