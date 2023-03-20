public with sharing class CadastroProdutoIntegracaoHandler {
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
        CadastroProdutoCalloutService.calloutServiceExecute();
    }
    private static void afterUpdate(){
        CadastroProdutoCalloutService.calloutServiceExecute();
    }
}