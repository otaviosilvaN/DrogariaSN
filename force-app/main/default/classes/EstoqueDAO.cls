public  class EstoqueDAO {
    
    public static Estoque__c createRecord(Mercadorias__c produto) {

        Estoque__c st = new Estoque__c();
       
        st.Name = produto.Name;
        st.Mercadoria__c = produto.Id;
        st.Categoria__c = produto.Categoria__c;
        st.Estoque_atual__c = 0;
        st.Estoque_minimo__c = produto.Estoque_minimo__c;
        st.Status_do_estoque__c = 'Normal';
        
        return st;
    }

    // Método que irá inserir quantidade de produtos que serão adicionados no objeto Alimentação do estoque 
    // no campo estoque atual
    
    /*
    public static Estoque__c createStockNumber(Alimentacao_Estoque__c estoque){
        Estoque__c e = new Estoque__c();
        e.Estoque_atual__c += estoque.Quantidade__c;

        return e;
    }
    */
    

    public static List<Estoque__c> getStockProductById(Id id){
        
        return [SELECT Mercadoria__c, Name, Estoque_atual__c, Estoque_minimo__c FROM Estoque__c WHERE Mercadoria__c = :id];
       
    }


}