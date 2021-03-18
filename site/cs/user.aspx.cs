using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class user : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if((string)Session["tipoCli"] ==  null)
        {
            Response.Redirect("login.aspx");
        }
        else
        {
            if((string)Session["tipoCli"] == "adm")
            {
                Response.Redirect("pgAdm.aspx");
            }

            lblNomeUser.Text = (string)Session["nomeCli"];
            Session["novaCompra"] = "SIM";
        }
    }

    protected void btnAlterar_Click(object sender, EventArgs e)
    {
        Response.Redirect("alterarUser.aspx");
    }

    protected void btnSair_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("login.aspx");
    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
        //sua festa - bolo ideal
        try
        {
            int num;
            num = Convert.ToInt32(txtNum.Text);

            if(num <= 15)
            {
                lblResp.Text = "Seu bolo ideal seria redondo pequeno ou de coração pequeno.";
            }
            if(num > 15 && num <= 20)
            {
                lblResp.Text = "Seu bolo ideal seria redondo médio ou de coração médio.";
            }
            if (num > 20 && num <= 25)
            {
                lblResp.Text = "Seu bolo ideal seria redondo grande, de coração grande ou retangular pequeno.";
            }
            if (num > 25 && num <= 30)
            {
                lblResp.Text = "Seu bolo ideal seria quadrado pequeno.";
            }
            if (num > 30 && num <= 35)
            {
                lblResp.Text = "Seu bolo ideal seria quadrado médio.";
            }
            if (num > 35 && num <= 40)
            {
                lblResp.Text = "Seu bolo ideal seria retangular médio.";
            }
            if (num > 40 && num <= 45)
            {
                lblResp.Text = "Seu bolo ideal seria quadrado grande.";
            }
            if (num > 45)
            {
                lblResp.Text = "Seu bolo ideal seria retangular grande.";
            }
            if (num > 100)
            {
                lblResp.Text = "Seu bolo ideal seria retangular grande (encomende dois).";
            }

        }
        catch
        {
            
        }
    }

    protected void btnOK2_Click(object sender, EventArgs e)
    {
        //sua festa - cores ideais
        try
        {
            DataView dvGen = (DataView)sqlGeneroEsc.Select(DataSourceSelectArguments.Empty);
            string tema = dvGen.Table.Rows[0]["nome_genero"].ToString();

            if (tema == "Casamento")
            {
                lblResp2.Text = "Utilize tons frios e branco.";
            }
            if (tema == "Festa Infantil")
            {
                lblResp2.Text = "Utilize cores vivas e quentes.";
            }
            if (tema == "Eventos")
            {
                lblResp2.Text = "Utilize tons claros para eventos formais.";
            }
            if (tema == "Aniversário")
            {
                lblResp2.Text = "Utilize cores frias ou preto com cores metálicas.";
            }
            if (tema == "Festa de 15 Anos")
            {
                lblResp2.Text = "Utilize combinações com preto e branco.";
            }
            if (tema == "Temático")
            {
                lblResp2.Text = "Utilize as cores predominantes de seu tema.";
            }
        }
        catch
        {

        }
        
    }

    protected void gvPedidosUser_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        //ir para detalhesPedido
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvPedidosUser, "Select$" + e.Row.RowIndex);
            e.Row.ToolTip = "Clique para ver mais detalhes.";
        }

    }

    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        //marcar como entregue
        foreach (GridViewRow row in gvPedidosUser.Rows)
        {
            CheckBox chk;

            chk = (CheckBox)row.FindControl("chk");

            if (chk.Checked == true)
            {
                string dataErrada = row.Cells[3].Text;
                DateTime dataEntrega = Convert.ToDateTime(dataErrada);
                DateTime dataAtual = DateTime.Now.Date;
                DateTime data3diasAtual = dataAtual.AddDays(3);

                if(dataEntrega.CompareTo(data3diasAtual) <= 0)
                {
                    lblMsgPedidos.Text = "Impossível cancelar pedido! Pedidos só podem ser cancelados três ou mais dias antes da data de entrega.";
                }
                else
                {
                    string id;
                    id = row.Cells[1].Text;
                    sqlPedidos.DeleteParameters["ID"].DefaultValue = id;
                    sqlPedidos.Delete();
                }               

            }            

        }
        gvPedidosUser.DataBind();
    }

    protected void gvPedidosUser_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvPedidosUser.Rows)
        {
            CheckBox chk;

            chk = (CheckBox)row.FindControl("chk");

            if(chk.Checked == false)
            {
                if (row.RowIndex == gvPedidosUser.SelectedIndex)
                {
                    Session["idPedido"] = gvPedidosUser.Rows[gvPedidosUser.SelectedIndex].Cells[1].Text;
                    Response.Redirect("detalhesPedido.aspx");
                }
            }           
        }            
    }
}