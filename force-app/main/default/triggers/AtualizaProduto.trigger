trigger AtualizaProduto on ordens_de_venda__c (after insert, after update) {
    AtualizaProdutoTriggerHandler.run(Trigger.operationType);
}