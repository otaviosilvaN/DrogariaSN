trigger AtualizaProdutoEstoque on ordens_de_venda__c (after insert, after update, before update) {
    AtualizaProdutoEstoqueTriggerHandler.run(Trigger.operationType);
}