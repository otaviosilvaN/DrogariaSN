
@RestResource(urlMapping = '/atualizarProdutos')

global with sharing class IntelliHubConnector {
    
    @HttpPost
    global static void atualizar(){
    // Será construída uma API no qual será integrada a um serviço externo, e recebido os dados para o SalesForce
    
    String json = RestContext.request.requestBody.toString();
    system.debug('DEBUG DO JSON '+ json);
    IntelliHubTO intellibrand = intelliHubTO.parse(json);
    system.debug('DEBUG INTELLIBRANDTO '+intellibrand);
    system.debug('DEBUG EAN - '+intellibrand.ean);
    
    List<Mercadorias__c> produtos = [SELECT Id, Name, EAN__c FROM Mercadorias__c WHERE EAN__C = :intellibrand.ean WITH SECURITY_ENFORCED];
    
    String eanProduto = intellibrand.ean;
    String urlImagem;

    List<Mercadorias__c> produtosUpdate = new List<Mercadorias__c>();
   
    for(Mercadorias__c p: produtos){
        system.debug('DEBUG DA LISTA que deu Match com ean - '+p);
        if(intellibrand.ean.contains(eanProduto)){
            //system.debug('PASSOU NA VALIDAÇÃO DO IF');
            for(intelliHubTO.Imagens img: intellibrand.imagens){
                p.Url_Imagem__c = img.url;
                produtosUpdate.add(p);
            }
            //system.debug('TAMANHO DA LISTA PRODUTOS UPDATE: '+produtosUpdate);
        }else{
            system.debug('EANS INCOMPATIVEIS!!');
        }
    }

    if(produtosUpdate.size()>0){
        Database.upsert(produtosUpdate);
        system.debug('Alteração feita com sucesso!!');
    }
}
}