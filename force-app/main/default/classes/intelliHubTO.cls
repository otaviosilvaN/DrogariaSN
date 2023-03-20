public with sharing class intelliHubTO {
    
    // JSON que será utilizado para atualizar imagens 
    public String ean                   {get;set;}
    
    public List<imagens> imagens        {get;set;}

    public  class Imagens{
        public String url               {get;set;}
        public String nome              {get;set;}
        public Integer posicao          {get;set;}
    }

    public class Titulo{
        public String ean               {get;set;}
        public String titulo            {get;set;}
    }

    public class Descricao{

        public String ean               {get;set;}
        public String descricao         {get;set;}
    }

    
    public  class ConsultarProduto{
        public String ean               {get;set;}
        public String  titulo           {get;set;}
        public String descricao         {get;set;}
        public List<imagens> imagens    {get;set;}
    }
    

    public class AtualizarImagens{
        public String ean               {get;set;}
        public List<Imagens> imagens    {get;set;}
    }
    // Dúvida: tenho 4 JSON diferentes ,de acordo com 4 endpoints passados. será necessário criar uma classe TO para cada JSON ou não?

    public static intelliHubTO parse(String json){
        return (intelliHubTO) System.JSON.deserialize(json, intelliHubTO.class);
    }

}