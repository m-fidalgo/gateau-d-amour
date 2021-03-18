using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class detalhesPedido : System.Web.UI.Page
{

    Criptografia cripto = new Criptografia("bblm");

    protected void Page_Load(object sender, EventArgs e)
    {
        if ((string)Session["tipoCli"] == null)
        {
            Response.Redirect("login.aspx");
        }
       
        //select
        DataView dvPedido = (DataView)sqlPedido.Select(DataSourceSelectArguments.Empty);

        if (dvPedido == null)
        {
            Response.Redirect("index.aspx");
        }

        //cliente
        lblCliNome.Text = dvPedido.Table.Rows[0]["nome_cli"].ToString();
        lblCliSobrenome.Text = dvPedido.Table.Rows[0]["sobrenome_cli"].ToString();
        lblCliEmail.Text = cripto.Decrypt(dvPedido.Table.Rows[0]["email_cli"].ToString());
        lblCliTel1.Text = dvPedido.Table.Rows[0]["tel1_cli"].ToString();

        string tel2;
        tel2 = dvPedido.Table.Rows[0]["tel2_cli"].ToString();
        if(tel2 == "")
        {
            lblCliTel2.Text = "-";
        }
        else
        {
            lblCliTel2.Text = tel2;
        }

        //endereço
        correiosWebService.AtendeClienteClient webServiceCorreios = new correiosWebService.AtendeClienteClient("AtendeClientePort");

        var infoCep = webServiceCorreios.consultaCEP(dvPedido.Table.Rows[0]["cep_end"].ToString());

        lblEndCidade.Text = infoCep.cidade;
        lblEndRua.Text = infoCep.end;
        lblEndNum.Text = dvPedido.Table.Rows[0]["num_end"].ToString();

        string comp = dvPedido.Table.Rows[0]["compl_end"].ToString();
        if(comp == "")
        {
            lblEndComp.Text = "-";
        }
        else
        {
            lblEndComp.Text = comp;
        }

        //pedido
        lblComentario.Text = dvPedido.Table.Rows[0]["comentario_pedido"].ToString();
        lblEstagio.Text = dvPedido.Table.Rows[0]["estagio_pedido"].ToString();
        lblPag.Text = dvPedido.Table.Rows[0]["nome_pag"].ToString();

        Double total = Convert.ToDouble(dvPedido.Table.Rows[0]["preco_compra"].ToString());
        lblTotal.Text = total.ToString("#0.00");

        DateTime data, dataEntrega, horarioEntrega;
        data = Convert.ToDateTime(dvPedido.Table.Rows[0]["data_pedido"].ToString());
        lblDataPedido.Text = data.ToShortDateString();

        dataEntrega = Convert.ToDateTime(dvPedido.Table.Rows[0]["dataEntrega_pedido"].ToString());
        lblDataEntrega.Text = dataEntrega.ToShortDateString();

        horarioEntrega = Convert.ToDateTime(dvPedido.Table.Rows[0]["horarioEntrega_pedido"].ToString());
        lblHorarioEntrega.Text = horarioEntrega.ToShortTimeString();

        pg("");      
    }

    protected void btnAnterior_Click(object sender, EventArgs e)
    {
        pg("Anterior");
    }

    protected void btnProx_Click(object sender, EventArgs e)
    {
        pg("Prox");
    }

    public void pg(string tipo)
    {
        int tamPg = 3;
        int regInicio = 0;

        if (ViewState["regInicio"] != null)
        {
            regInicio = (int)ViewState["regInicio"];
        }

        if (tipo == "Prox")
        {
            regInicio = regInicio + tamPg;
        }
        if (tipo == "Anterior" && regInicio > 0)
        {
            regInicio = regInicio - tamPg;
        }

        //criar uma DataTable e colocar nela o resultado da pesquisa
        DataTable dtProd = new DataTable();
        
        DataView dvExibir = (DataView)sqlExibir.Select(DataSourceSelectArguments.Empty);

        if (dvExibir.Table.Rows.Count == 0)
        {
            Response.Redirect("index.aspx");
        }

        dtProd = dvExibir.Table.Clone();

        //importando os itens
        for (int i = regInicio; i < (regInicio + tamPg); i++)
        {
            if (i < dvExibir.Table.Rows.Count)
            {
                dtProd.ImportRow(dvExibir.Table.Rows[i]);
            }
        }

        if (tipo == "Prox" && dtProd.Rows.Count == 0 && regInicio > 0)
        {
            regInicio = regInicio - tamPg;

            for (int i = regInicio; i < (regInicio + tamPg); i++)
            {
                if (i < dvExibir.Table.Rows.Count)
                {
                    dtProd.ImportRow(dvExibir.Table.Rows[i]);
                }
            }
        }

        //estabelecendo a fonte de dados do DataList como o DataTable
        dlProd.DataSource = dtProd;
        dlProd.DataBind();

        ViewState["regInicio"] = regInicio;
    }
}