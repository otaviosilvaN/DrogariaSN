public with sharing class placeHolderWebServiceHandler {
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
        // A trigger irá sempre rodar a classe de integração de produto assim que uma nova categoria for inserida/atualizada
        
        Mercadorias__c produtos = (Mercadorias__c) trigger.new[0];
        List<String> listEan = new List<String>();
        listEan.add(produtos.EAN__c);
        placeHolderWebService.calloutService(listEan);
    }
    private static void afterUpdate(){

        Mercadorias__c produtos = (Mercadorias__c) trigger.new[0];
        List<String> listEan = new List<String>();
        listEan.add(produtos.EAN__c);
        
        if(System.IsBatch() == false && System.isFuture() == false){ 
            placeHolderWebService.calloutService(listEan);
        }
    }
}