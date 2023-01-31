public with sharing class MercadoriasDAO {
    public static Mercadorias__c getRecordById(Id id) {
       
        return [SELECT Ativo__c FROM Mercadorias__c where Id = :id];
        

    }
}