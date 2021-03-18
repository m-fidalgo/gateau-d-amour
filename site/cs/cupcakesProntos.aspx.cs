using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class cupcakesProntos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnPesq_Click(object sender, EventArgs e)
    {
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
        dlCupcake.Visible = true;
        lblErro.Text = "";

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

        sqlExibir.SelectParameters["PESQ"].DefaultValue = txtPesq.Text + "%";
        DataView dv = (DataView)sqlExibir.Select(DataSourceSelectArguments.Empty);

        if (dv.Table.Rows.Count == 0)
        {
            dlCupcake.Visible = false;
            lblErro.Text = "Produto não encontrado";
        }

        dtProd = dv.Table.Clone();

        //importando os itens
        for (int i = regInicio; i < (regInicio + tamPg); i++)
        {
            if (i < dv.Table.Rows.Count)
            {
                dtProd.ImportRow(dv.Table.Rows[i]);
            }
        }
        
        if (tipo == "Prox" && dtProd.Rows.Count == 0 && regInicio > 0)
        {
            regInicio = regInicio - tamPg;

            for (int i = regInicio; i < (regInicio + tamPg); i++)
            {
                if (i < dv.Table.Rows.Count)
                {
                    dtProd.ImportRow(dv.Table.Rows[i]);
                }
            }
        }

        //estabelecendo a fonte de dados do DataList como o DataTable
        dlCupcake.DataSource = dtProd;
        dlCupcake.DataBind();

        ViewState["regInicio"] = regInicio;
    }
}