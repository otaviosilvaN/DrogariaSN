Trigger SendEmail on Nota_Fiscal__c(after Insert){
    if(Trigger.isInsert && Trigger.isAfter){
        SendEmailTriggerHandler.sendEmailNotification(Trigger.new);
        
    }
    
}