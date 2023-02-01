public with sharing class AlimentarEstoqueProdutoTriggerHandler {
   
    public static void run(System.TriggerOperation triggerEvent) {
   
        switch on triggerEvent{
            when AFTER_INSERT{
                afterInsert();
            }
 
            /*when AFTER_UPDATE{
             afterUpdate();
         }*/
            
        }
    }

    private static void afterInsert(){
        // A trigger irá atuar no objeto Alimentação Estoque, onde após criação de um registro de quantidade de produto, irá atualizar no objeto estoque do produto 
        Alimentacao_Estoque__c inserirEstoque = (Alimentacao_Estoque__c) trigger.new[0];
        // Consulta para buscar informações do estoque do produto 
        List<Estoque__c> estoqueList = EstoqueDAO.getStockProductById(inserirEstoque.Mercadoria__c);
        // Lista que irá receber os registro a serem atualizados
        List<Estoque__c> estoqueUpdate = new List<Estoque__c>();

        system.debug('DEBUG ESTOQUE QUANTITY'+ estoqueList);
        
        for(Estoque__c e: estoqueList){
            if(e.Mercadoria__c == inserirEstoque.Mercadoria__c){
                e.Estoque_atual__c += inserirEstoque.Quantidade__c;
                system.debug('DEBUG DO ESTOQUE ATUALIZADO' + e.Estoque_atual__c);
            }
            system.debug('DEBUG CONTEÚDO DA LISTA' + e);
            estoqueUpdate.add(e);
            system.debug('DEBUG ESTOQUE UPDATE: '+ estoqueUpdate);
        }
        
        update estoqueUpdate;

    }

    
}