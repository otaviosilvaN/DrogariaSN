trigger AtivacaoProduto on Estoque__c (after insert, after update) {
    AtivacaoProdutoTriggerHandler.run(Trigger.operationType);
}