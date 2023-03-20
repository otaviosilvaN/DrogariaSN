//public with sharing class CadastroProdutoCalloutService implements Queueable, Database.AllowsCallouts{

public with sharing class CadastroProdutoCalloutService implements Database.AllowsCallouts{

    private static final String PRODUTO_URL = 'https://salesforceintegration.otavioluiz3.repl.co/produtos';

    @future(callout = true)
    public static void calloutServiceExecute(){
    //public  void execute(QueueableContext context){

        Http h = new Http();
        HttpRequest httpReq = new HttpRequest();
        httpReq.setMethod('GET');
        httpReq.setHeader('Content-Type','application/json'); 
        httpReq.setEndpoint(PRODUTO_URL);
        HttpResponse res = h.send(httpReq);

        List<Mercadorias__c> produtos = new List<Mercadorias__c>();

        if(res.getStatusCode() == 200){
            List<Object> jsonResponse = (List<Object>) JSON.deserializeUntyped(res.getBody());
            System.debug('DEBUG DO RESPONSE '+ jsonResponse.size());

            for(Object ob : jsonResponse){

                Map<String, Object> mapJson =  (Map<String, Object>)ob;
                system.debug('DEBUG DO MAP '+mapJson);

                Mercadorias__c p = new Mercadorias__c();
                
                // Recuperando Mercadorias já cadastradas
                // Como posso executar esse query fora do For
                List<Mercadorias__c>listProd = [SELECT Id, Name FROM Mercadorias__c WHERE Name =: (String) mapJson.get('Nome do produto')];
                List<String> newList = new List<String>();

                for(Mercadorias__c prod :listProd){
                    system.debug('DEBUG DA LISTA DE PROD: '+ prod);
                    newList.add(prod.Name);
                }

                if(!newList.contains((String) mapJson.get('Nome do produto'))){
                    
                    p.Name = (String) mapJson.get('Nome do produto');
                    p.Descricao__c = (String) mapJson.get('Descrição');
                    
                    // Selecionando o Id da categoria para cadastro de acordo com o nome recebido pela API
                    
                    String idCategoria;
                    //Como posso executar essa query fora do For?
                    List<Categoria__c> categoria = [SELECT Id FROM Categoria__c WHERE name = : (String) mapJson.get('Categoria')];
                    
                    try{
                        if(categoria.size() > 0){
                            for(Categoria__c c: categoria){
                                idCategoria = c.id;
                            }
                            p.Categoria__c = idCategoria;
                        }
                    }catch (Exception e){
                        system.debug('Categoria não encontrada!!'+e);
                    } 

                    p.Preco__c = (Decimal) mapJson.get('Valor Unitario');
                    p.Estoque_minimo__c = (Integer) mapJson.get('Estoque Minimo');
                    produtos.add(p);
                    
                }else{
                    system.debug('Produto já adicionado');
                }
            }

            if(produtos.size()> 0){
                upsert produtos;
                system.debug('Lista de mercadorias atualizada');
            }
        }
}   }