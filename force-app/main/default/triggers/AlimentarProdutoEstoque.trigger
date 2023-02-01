trigger AlimentarProdutoEstoque on Alimentacao_Estoque__c (after insert, after update) {
    AlimentarEstoqueProdutoTriggerHandler.run(Trigger.operationType);
}