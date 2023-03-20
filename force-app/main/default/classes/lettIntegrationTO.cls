public class lettIntegrationTO {

    public List<ProductTOLett> data;

    // Foto primária
    public class Pic_primary{
        public List<String> original {get;set;}
    }

    // Foto secundária
    public class Pic_secondary{
        public List<String> original {get;set;}
    }

    // Atributos
    public class Attributes{
        public String name                  {get;set;}
        public Integer sku                  {get;set;}
        public String description           {get;set;}
        public Pic_primary pic_primary      {get;set;}
        public Pic_secondary pic_secondary  {get;set;}
        public String keywords              {get;set;}
    }

    // Fornecedor
    public class Supplier{
        public Integer id       {get;set;}
        public String fullName  {get;set;}
    }

    // Marca
    public class Brand{
        public Integer id       {get;set;}
        public String fullName  {get;set;}
    }

    // Categories lett
    public class Family{
        public Integer id   {get;set;}
        public String name  {get;set;}
    }
    public class Classe{
        public Integer id   {get;set;}
        public String name  {get;set;}
    }
    public class Brick{
        public Integer id   {get;set;}
        public String name  {get;set;}
    }

    // Data = Product
    public class ProductTOLett{
        public Integer id               {get;set;}
        public String ean               {get;set;}
        public Brand brand              {get;set;}
        public Supplier supplier        {get;set;}
        public Attributes attributes    {get;set;}
    }

    public static lettIntegrationTO parse(String json){
        return (lettIntegrationTO) System.JSON.deserialize(json, lettIntegrationTO.class);
    }

}