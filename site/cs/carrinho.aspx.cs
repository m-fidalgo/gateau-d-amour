using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class carrinho : System.Web.UI.Page
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
                try
                {
                    calcularTotal();
                }
                catch { }
            }           
        }        
    }

    private void calcularTotal()
    {
        DataView dvTotal = (DataView)sqlTotal.Select(DataSourceSelectArguments.Empty);

        lblTotal.Text = dvTotal.Table.Rows[0]["total"].ToString();
    }

    protected void dtCarrinho_DeleteCommand(object source, DataListCommandEventArgs e)
    {
        //excluir item
        int id_prod = Convert.ToInt32(dtCarrinho.DataKeys[e.Item.ItemIndex]);
        sqlExcluir.DeleteParameters["IDPROD"].DefaultValue = Convert.ToString(id_prod);
        sqlExcluir.Delete();
        calcularTotal();
        dtCarrinho.DataBind();
    }


    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        //cancelar pedido
        Session["novaCompra"] = "SIM";
        sqlCancelar.Delete();
        Session["idPedido"] = null;
        Response.Redirect("index.aspx");
    }

    protected void btnComprar_Click(object sender, EventArgs e)
    {
        //seguir com a compra
        sqlComprar.UpdateParameters["TOTAL"].DefaultValue = lblTotal.Text.Replace(',', '.');
        sqlComprar.Update();
        Response.Redirect("finalizarCompra.aspx");
    }
}