package model;

public class produtoLista {
    private Integer id_prod;
    private Integer id_cat;
    private Double preco_prod;
    private String nome_prod;
    private String imagem;

    public Integer getId_prod() {
        return id_prod;
    }

    public void setId_prod(Integer id_prod) {
        this.id_prod = id_prod;
    }

    public Integer getId_cat() {
        return id_cat;
    }

    public void setId_cat(Integer id_cat) {
        this.id_cat = id_cat;
    }

    public Double getPreco_prod() {
        return preco_prod;
    }

    public void setPreco_prod(Double preco_prod) {
        this.preco_prod = preco_prod;
    }

    public String getNome_prod() {
        return nome_prod;
    }

    public void setNome_prod(String nome_prod) {
        this.nome_prod = nome_prod;
    }

    public String getImagem() {
        return imagem;
    }

    public void setImagem(String imagem) {
        this.imagem = imagem;
    }
}
