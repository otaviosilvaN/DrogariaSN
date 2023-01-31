@isTest
public with sharing class SendEmailTriggerHandlerTest {
    @isTest static void testSendEmailNotification() {
        List<Messaging.Email>emailList = new List<Messaging.Email>();
        
        Nota_Fiscal__c nfe = new Nota_Fiscal__c();
        nfe.Email_do_cliente__c = 'otavio3397@gmail.com'; 
        nfe.Quantidade__c = 2;
        nfe.Valor_Total__c = 200;
    
        Insert nfe;
        
        Test.startTest();
            if(nfe.Email_do_cliente__c != null){

                Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
                
                String[] toAdress = new String[]{'otavio3397@gmail.com'};
                emailMsg.setToAddresses(toAdress);
                emailMsg.setSubject('Pedido teste');
                emailMsg.setSenderDisplayName('Teste');
                // Corpo da mensagem
                emailMsg.setHtmlBody('Teste de email em html <br><br>');
                emailList.add(emailMsg);
                // Adicionando o email a lista de emails
            
                Messaging.sendEmail(emailList);
            }
        Test.stopTest();
        Integer invocations = Limits.getEmailInvocations();
        System.assertEquals(1, invocations, 'Um email deve ser enviado');
        }

    }