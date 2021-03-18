package utils;

public abstract class produtos {
    private static Integer id_prod;
    private static Integer id_cat;


    public static Integer getId_prod() {
        return id_prod;
    }

    public static void setId_prod(Integer id_prod) {
        produtos.id_prod = id_prod;
    }

    public static Integer getId_cat() {
        return id_cat;
    }

    public static void setId_cat(Integer id_cat) {
        produtos.id_cat = id_cat;
    }
}
