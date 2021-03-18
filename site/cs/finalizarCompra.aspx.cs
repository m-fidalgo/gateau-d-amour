using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class finalizarCompra : System.Web.UI.Page
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
            else
            {
                if ((string)Session["novaCompra"] == "SIM")
                {
                    Response.Redirect("index.aspx");
                }
            }
        }
    }

    protected void btnVoltar_Click(object sender, EventArgs e)
    {
        Response.Redirect("carrinho.aspx");
    }

    protected void btnFinalizar_Click(object sender, EventArgs e)
    {
        //inserir na tabela endereço
        sqlEndereco.Insert();

        if (ddlPagamento.SelectedItem.Text == "SELECIONE")
        {
            lblMsg.Text = "Selecione um valor";
        }
        else
        {
            //update na tabela pedidos - colocar nela as informações dadas pelo usuário
            DataView dvEnd = (DataView)sqlEndereco.Select(DataSourceSelectArguments.Empty);
            sqlComprar.UpdateParameters["END"].DefaultValue = dvEnd.Table.Rows[0]["end"].ToString();

            DateTime dt = DateTime.Now.Date;
            DateTime data3diasDaAtual = dt.AddDays(3);
            DateTime dataEntrega = Convert.ToDateTime(txtData.Text);

            if(dataEntrega.CompareTo(data3diasDaAtual) <= 0)
            {
                txtData.Text = "";
                lblMsg.Text = "Data inválida! Precisamos de, ao menos, três dias de antecedência";
            }
            else
            {
                String dataP = dt.ToString("yyyy/MM/dd");
                sqlComprar.UpdateParameters["DATA"].DefaultValue = dataP;

                String dataCorreta = dataEntrega.ToString("yyyy/MM/dd");
                sqlComprar.UpdateParameters["DATAENTREGA"].DefaultValue = dataCorreta;

                DateTime horario = Convert.ToDateTime(txtHorario.Text);
                String horarioCorreto = horario.ToString("t");

                sqlComprar.UpdateParameters["HORARIO"].DefaultValue = horarioCorreto;
                sqlComprar.Update();
                lblMsg.Text = string.Empty;

                //verificar se o pagamento é por cartão
                if (ddlPagamento.SelectedValue == "2")
                {
                    Response.Redirect("finalizarPagCompra.aspx");
                }
                else
                {
                    Session["idPedido"] = null;
                    Session["novaCompra"] = "SIM";
                    Response.Redirect("compraFinalizada.aspx");
                }
            }
        }          
    }
}