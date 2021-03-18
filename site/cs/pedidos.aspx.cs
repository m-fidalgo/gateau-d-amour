using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class pedidos : System.Web.UI.Page
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

            DataView dvGrid = (DataView)sqlPedidos.Select(DataSourceSelectArguments.Empty);
        }
    }

    protected void gvPedidosAdm_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        //ir para detalhesPedido
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvPedidosAdm, "Select$" + e.Row.RowIndex);
            e.Row.ToolTip = "Clique para ver mais detalhes.";
        }
        
    }

    protected void gvPedidosAdm_SelectedIndexChanged(object sender, EventArgs e)
    {       
        //marcar como entregue
        foreach (GridViewRow row in gvPedidosAdm.Rows)
        {
            CheckBox chk;

            chk = (CheckBox)row.FindControl("chk");

            if (chk.Checked == true)
            {
                string id;
                id = row.Cells[1].Text;
                sqlPedidos.UpdateParameters["ID"].DefaultValue = id;
                sqlPedidos.Update();

            }
            else
            {
                if (row.RowIndex == gvPedidosAdm.SelectedIndex)
                {
                    Session["idPedido"] = gvPedidosAdm.Rows[gvPedidosAdm.SelectedIndex].Cells[1].Text;
                    Response.Redirect("detalhesPedido.aspx");
                }
            }

        }
        gvPedidosAdm.DataBind();
    }
}