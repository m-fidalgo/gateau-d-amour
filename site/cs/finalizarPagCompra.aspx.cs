using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;

public partial class finalizarPagCompra : System.Web.UI.Page
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
            if ((string)Session["tipoCli"] == "adm")
            {
                Response.Redirect("pgAdm.aspx");
            }
            else
            {
                if ((string)Session["novaCompra"] == "SIM")
                {
                    Response.Redirect("index.aspx");
                }
            }
        }
    }

    protected void btnFinalizar_Click(object sender, EventArgs e)
    {
        try
        {
            //inserir na tabela cartao
            DateTime data = Convert.ToDateTime(txtValidade.Text);
            String dataCorreta = data.ToString("yyyy/MM/dd");
            sqlCartao.InsertParameters["VAL"].DefaultValue = dataCorreta;
            sqlCartao.InsertParameters["NUM"].DefaultValue = cripto.Encrypt(txtNum.Text);
            sqlCartao.InsertParameters["NOME"].DefaultValue = cripto.Encrypt(txtNome.Text);
            sqlCartao.InsertParameters["COD"].DefaultValue = cripto.Encrypt(txtCodSeg.Text);
            sqlCartao.InsertParameters["CPF"].DefaultValue = cripto.Encrypt(txtCPF.Text);
            sqlCartao.Insert();

            DataView dv = (DataView)sqlCartao.Select(DataSourceSelectArguments.Empty);
            sqlComprar.UpdateParameters["IDCARTAO"].DefaultValue = dv.Table.Rows[0]["cartao"].ToString();
            sqlComprar.Update();
            Session["idPedido"] = null;
            Session["novaCompra"] = "SIM";
            Response.Redirect("compraFinalizada.aspx");
        }
        catch
        {
            lblMsg.Text = "Não foi possível cadastrar o cartão";   
        }
        
    }
}