trigger CadastrarProdutoNoEstoque on Mercadorias__c (after insert, after update) {
    ProdutoTriggerHandler.run(Trigger.operationType);
}