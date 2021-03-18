using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class receitas : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((string)Session["tipoCli"] == "adm")
        {
            Response.Redirect("pgAdm.aspx");
        }

        //gambiarra file upload
        LinkButton1.Attributes.Add("onclick", "document.getElementById('" + fuImagem.ClientID + "').click(); return false;");
    }

    protected void btnEnviar_Click(object sender, EventArgs e)
    {
        if ((string)Session["tipoCli"] == null)
        {
            Response.Redirect("login.aspx");
        }
        else
        {
            try
            {
                //imagem
                string url, nomeFoto;

                nomeFoto = fuImagem.FileName;

                if (nomeFoto != "")
                {
                    fuImagem.SaveAs(Server.MapPath("~\\imgs\\receitas\\" + nomeFoto));
                    url = "~\\imgs\\receitas\\" + nomeFoto;
                }
                else
                {
                    url = "~\\imgs\\produtos\\noImg.png";
                }

                //insert
                sqlReceitas.InsertParameters["INGRED"].DefaultValue = txtIngredientes.Text.Replace(Environment.NewLine, "\n");
                sqlReceitas.InsertParameters["MODO"].DefaultValue = txtModo.Text.Replace(Environment.NewLine, "\n");
                sqlReceitas.InsertParameters["IMG"].DefaultValue = url;                
                sqlReceitas.Insert();

                //limpar campos
                txtIngredientes.Text = null;
                txtModo.Text = null;
                txtTitulo.Text = null;
                lblMsg.Text = "Sua receita foi enviada com sucesso!";
            }
            catch
            {
                lblMsg.Text = "Não foi possível enviar sua receita, tente novamente";
                txtIngredientes.Text = null;
                txtModo.Text = null;
                txtTitulo.Text = null;
            }        
        }
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
        dlReceitas.Visible = true;
        lblErro.Text = "";

        int tamPg = 1;
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
        DataTable dtReceita = new DataTable();
        sqlExibir.SelectParameters["PESQ"].DefaultValue = txtPesq.Text + "%";
        DataView dv = (DataView)sqlExibir.Select(DataSourceSelectArguments.Empty);

        if (dv.Table.Rows.Count == 0)
        {
            dlReceitas.Visible = false;
            lblErro.Text = "Receita não encontrada";
        }

        dtReceita = dv.Table.Clone();

        //importando os itens
        for (int i = regInicio; i < (regInicio + tamPg); i++)
        {
            if (i < dv.Table.Rows.Count)
            {
                dtReceita.ImportRow(dv.Table.Rows[i]);
            }
        }

        if (tipo == "Prox" && dtReceita.Rows.Count == 0 && regInicio > 0)
        {
            regInicio = regInicio - tamPg;

            for (int i = regInicio; i < (regInicio + tamPg); i++)
            {
                if (i < dv.Table.Rows.Count)
                {
                    dtReceita.ImportRow(dv.Table.Rows[i]);
                }
            }
        }

        //estabelecendo a fonte de dados do DataList como o DataTable
        dlReceitas.DataSource = dtReceita;
        dlReceitas.DataBind();

        ViewState["regInicio"] = regInicio;
    }

}
