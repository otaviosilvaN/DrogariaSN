public with sharing class AtivacaoProdutoTriggerHandler {
    public static void run (System.TriggerOperation triggerEvent) {
   
        switch on triggerEvent{

           /* when AFTER_INSERT{
                afterInsert();
            }
            */
 
            when AFTER_UPDATE{
                afterUpdate();
            }
            
        }
        
    }
    // Após o Estoque do produto estiver zerado, o mesmo é inativo, impedindo novas vendas no sistema.
    public static void afterUpdate (){
        Estoque__c estoque = (Estoque__c) trigger.New[0];

        List<Mercadorias__c> produtos = ProdutoDAO.getProductsById(estoque.Mercadoria__c);
        List<Mercadorias__c> produtosUpdate = new List<Mercadorias__c>();

        for(Mercadorias__c p: produtos){
            if(p.Id == estoque.Mercadoria__c ){
                if(estoque.Estoque_atual__c < = 0){
                    p.Ativo__c = false;
                }
            }
            produtosUpdate.add(p);
        }
        update produtosUpdate;
    }  


}