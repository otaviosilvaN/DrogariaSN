public with sharing class ProdutoDAO {
    
    public static List<Mercadorias__c> getProductsById(Id id) {
        return [SELECT Id, Name FROM Mercadorias__c WHERE Id = :id];

    }
}