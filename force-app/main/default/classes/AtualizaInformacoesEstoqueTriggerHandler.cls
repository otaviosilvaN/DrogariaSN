public with sharing class AtualizaInformacoesEstoqueTriggerHandler {
    public static void run(System.TriggerOperation triggerEvent) {

        switch on triggerEvent {

            when AFTER_UPDATE{
                afterUpdate();
            }
        }
    }

    // Caso precise atualizar o nome geral do produto no objeto produto, atualizar também o nome dele no estoque.
    // O relacionamento atualiza automaticamente, porém o nome geral não.
    private static void afterUpdate(){

        Mercadorias__c produtos = (Mercadorias__c) trigger.new[0];

        List <Estoque__c> estoque = EstoqueDAO.getStockProductById(produtos.Id);

        for(Estoque__c e: estoque){
            if(e.Mercadoria__c == produtos.Id){
                e.Name = produtos.Name;
            }
            update e;
        }
        

    }
}