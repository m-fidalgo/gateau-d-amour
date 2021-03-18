package model;

public class produtoDetalhes {
    private Integer id_prod;
    private Double preco_prod;
    private String nome_prod;
    private String imagem;
    private Double class_prod;
    private Integer nota;

    public Integer getId_prod() {
        return id_prod;
    }

    public void setId_prod(Integer id_prod) {
        this.id_prod = id_prod;
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

    public Double getClass_prod() {
        return class_prod;
    }

    public void setClass_prod(Double class_prod) {
        this.class_prod = class_prod;
    }

    public Integer getNota() {
        return nota;
    }

    public void setNota(Integer nota) {
        this.nota = nota;
    }
}
