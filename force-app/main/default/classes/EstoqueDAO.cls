public  class EstoqueDAO {
    
    public static Estoque__c createRecord(Mercadorias__c produto) {

        Estoque__c st = new Estoque__c();
       
        st.Name = produto.Name;
        st.Mercadoria__c = produto.Id;
        st.Categoria__c = produto.Categoria__c;
        st.Estoque_atual__c = produto.Quantidade__c;
        st.Estoque_minimo__c = produto.Estoque_minimo__c;
        st.Status_do_estoque__c = 'Normal';
        
        return st;
    }

    
    /*public static Estoque__c updateRecord(ordens_de_venda__c ordens){
        
        Estoque__c st = new Estoque__c();

    }
    */
    

    public static List<Estoque__c> getStockProductById(Id id){
        
        return [SELECT Mercadoria__c, Name, Estoque_atual__c, Estoque_minimo__c FROM Estoque__c WHERE Mercadoria__c = :id];
       
    }


}