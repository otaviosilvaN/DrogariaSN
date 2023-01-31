public with sharing class DeleteRecordsByStatus{

    /*public Static PageReference redirectToHome() {
        PageReference pgRef = new pageReference('/lightning/o/ordens_de_venda__c/list?filterName=Recent');
        pgRef.setRedirect(true);
        return pgRef;
       
    } 
    */
    


     public Static void deleteRecordsByStatus(List<Ordens_de_venda__c> ov) {
        
        Ordens_de_venda__c orders = (Ordens_de_venda__c) Trigger.new[0];
         
        // Lista de registros novos = Trigger.new
        Ordens_de_venda__c [] cancelOrders = [SELECT Id, Name, Status__c FROM Ordens_de_venda__c WHERE Status__c = 'Cancelado'];
        
        try{
            delete cancelOrders;
            //DeleteRecordsByStatus.redirectToHome();
            
            
        } catch (DmlException e){
            orders.addError('Registros não encontrados!!');

            
        }

    }   
     
}