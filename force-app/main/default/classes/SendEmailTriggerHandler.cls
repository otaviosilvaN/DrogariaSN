public with sharing class SendEmailTriggerHandler{
    public static void sendEmailNotification (List<Nota_Fiscal__c> listNf) {
        // Criação da Lista de email
        List<Messaging.Email>emailList = new List<Messaging.Email>();
        for(Nota_Fiscal__c nf : listNf){
            // Caso o campo e-mail do objeto Nota Fiscal estiver preenchido
            if(nf.Email_do_cliente__c != null){
                // Ele irá criar um email com as informações desejadas
                // Instanciando o objeito Messaging
                Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
                String[] toAdress = new String[]{nf.Email_do_cliente__c};
                emailMsg.setToAddresses(toAdress);
                String emailSubj = 'Pedido nº'+ nf.Ordem_de_venda__c;
                emailMsg.setSubject(emailSubj);
                String disName = 'Drogaria Silva&Nunes';
                emailMsg.setSenderDisplayName(disName);
                
                // Corpo da mensagem
                String content = 'Olá '+nf.Cliente__c + '<br>'+'Seu pedido nº ' + nf.Ordem_de_venda__c+ ' foi aprovado!!<br><br> '+
                +'<b>INFORMAÇOES:</b> <br>'+
                '<b>Produto:</b> '+nf.Mercadoria__c+'<br>'+
                '<b>Valor Unitário:</b> '+nf.Valor_Unitario__c+'<br>'+
                '<b>Quantidade:</b> '+nf.Quantidade__c+'<br>'+
                '<b>Valor total:</b> R$'+nf.Valor_Total__c;
                emailMsg.setHtmlBody(content);
                // Adicionando o email a lista de emails
                emailList.add(emailMsg);
                //

            }
        }
        // Enviando email
        Messaging.sendEmail(emailList);
    }
}