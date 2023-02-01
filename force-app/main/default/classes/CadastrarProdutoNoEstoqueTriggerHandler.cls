public with sharing class CadastrarProdutoNoEstoqueTriggerHandler {

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
       Mercadorias__c produto = (Mercadorias__c) trigger.new[0];
       
       if(produto.Ativo__c == true){
           
           insert EstoqueDAO.createRecord(produto);
           List<Estoque__c> lista = EstoqueDAO.getStockProductById(produto.Id);

       }
   }

   private static void afterUpdate(){
    Mercadorias__c produto = (Mercadorias__c) trigger.new[0];

    if(produto.Ativo__c == true){
        
        List <Estoque__c> estoque = EstoqueDAO.getStockProductById(produto.id);
        /*for(Estoque__c e: estoque){
            system.debug(e.Name);
        }
        */
    
        if(estoque.isEmpty()){
			insert EstoqueDAO.createRecord(produto);
            //insert EstoqueDAO.createStockNumber(inserirEstoque);       
        }
        
    }

            
    }
        
}