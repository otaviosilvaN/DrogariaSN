public with sharing class AtualizaProdutoTriggerHandler {
    public static void run(System.TriggerOperation triggerEvent) {
   
        switch on triggerEvent{
            when AFTER_INSERT{
                afterInsert();
            }
 
            when AFTER_UPDATE{
             afterUpdate();
         }
            
        }
    }
 
    private static void afterInsert(){
        
        ordens_de_venda__c ordens = (ordens_de_venda__c) trigger.new[0];
        List <Estoque__c> estoque = EstoqueDAO.getStockProductById(ordens.Mercadoria__c);
        
        /*if(estoque.isEmpty()){
            update EstoqueDAO.updateRecord(produto);
        }
        */

    }

    private static void afterUpdate(){
        // Code here
    }

 
}