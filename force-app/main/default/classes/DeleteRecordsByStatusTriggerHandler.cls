public with sharing class DeleteRecordsByStatusTriggerHandler{
    public Static void deleteRecordsByStatus(List<Ordens_de_venda__c> ov) {
        Ordens_de_venda__c orders = (Ordens_de_venda__c) Trigger.new[0];
         
        // Lista de registros novos = Trigger.new
        Ordens_de_venda__c [] cancelOrders = [SELECT Id, Name, Status__c FROM Ordens_de_venda__c WHERE Status__c = 'Cancelado'];
        
        try{
            delete cancelOrders;
            
        } catch (DmlException e){
            orders.addError('Você não pode ativar um contrato com um proprietário inativo');

            
        }

    }       
}