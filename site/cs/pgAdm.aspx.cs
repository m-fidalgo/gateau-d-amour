using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;


public partial class pgAdm : System.Web.UI.Page
{

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

        try
        {
            DataView dv = (DataView)sqlTotalProdAno.Select(DataSourceSelectArguments.Empty);
            lblTotalProdAno.Text = dv.Table.Rows[0]["somaProdAno"].ToString();

            DataView dv1 = (DataView)sqlTotalProdMes.Select(DataSourceSelectArguments.Empty);
            lblTotalProdMes.Text = dv1.Table.Rows[0]["somaProdMes"].ToString();

            DataView dv2 = (DataView)sqlFaturAno.Select(DataSourceSelectArguments.Empty);
            lblFaturamentoAno.Text = dv2.Table.Rows[0]["faturAno"].ToString();

            DataView dv3 = (DataView)sqlFaturMes.Select(DataSourceSelectArguments.Empty);
            lblFaturamentoMes.Text = dv3.Table.Rows[0]["faturMes"].ToString();

            DataView dvReceitas = (DataView)sqlExibir.Select(DataSourceSelectArguments.Empty);

            if (dvReceitas.Table.Rows.Count == 0)
            {
                dlReceitas.Visible = false;
                lblMsg.Text = "Não há nenhuma receita para análise";
            }
        }
        catch
        {

        }        
    }

    protected void btnSair_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("login.aspx");
    }


    protected void btnCadastrar_Click(object sender, EventArgs e)
    {
        Response.Redirect("cadastrarAdm.aspx");
    }

    protected void dlReceitas_DeleteCommand(object source, DataListCommandEventArgs e)
    {
        //apagar a receita
        int id_receita = Convert.ToInt32(dlReceitas.DataKeys[e.Item.ItemIndex]);
        sqlExcluir.DeleteParameters["ID"].DefaultValue = Convert.ToString(id_receita);
        sqlExcluir.Delete();        
        dlReceitas.DataBind();
    }

    protected void dlReceitas_UpdateCommand(object source, DataListCommandEventArgs e)
    {
        //update - marcar como publicada
        int id_receita = Convert.ToInt32(dlReceitas.DataKeys[e.Item.ItemIndex]);
        sqlExcluir.UpdateParameters["ID"].DefaultValue = Convert.ToString(id_receita);
        sqlExcluir.Update();
        dlReceitas.DataBind();
    }
}