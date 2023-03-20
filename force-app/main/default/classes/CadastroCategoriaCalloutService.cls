//public with sharing class CadastroProdutoCalloutService implements Queueable, Database.AllowsCallouts{

    public with sharing class CadastroCategoriaCalloutService implements Database.AllowsCallouts{

        private static final String CATEGORIA_URL = 'https://salesforceintegration.otavioluiz3.repl.co/categoria';
    
        //@future(callout = true)
        public static void calloutServiceExecute(){
        //public  void execute(QueueableContext context){
    
            Http h = new Http();
            HttpRequest httpReq = new HttpRequest();
            httpReq.setMethod('GET');
            httpReq.setHeader('Content-Type','application/json'); 
            httpReq.setEndpoint(CATEGORIA_URL);
            HttpResponse res = h.send(httpReq);
    
            List<Categoria__c> categorias = new List<Categoria__c>();
    
            if(res.getStatusCode() == 200){
                List<Object> jsonResponse = (List<Object>) JSON.deserializeUntyped(res.getBody());
                System.debug('DEBUG DO RESPONSE '+ jsonResponse.size());
                
                
                for(Object ob : jsonResponse){
                    system.debug('DEBUG DO OBJETO ' +ob);
                    Map<String, Object> mapJson =  (Map<String, Object>)ob;
                    system.debug('DEBUG DO MAP '+mapJson);

                    Categoria__c c = new Categoria__c();

                    // Recuperando Categorias já cadastradas
                    String nomeJson = (String) mapJson.get('Nome da Categoria');
                    String descricaoJson = (String) mapJson.get('Descrição');

                    List<Categoria__c> listCat = [SELECT  Name, Descricao__c FROM Categoria__c WHERE Name =: nomeJson];

                    List<String>newList = new List<String>();
                    
                    for(Categoria__c cat :listCat){
                        system.debug('DEBUG DA LISTA DE CATEGORIA: '+ cat);
                        newList.add(cat.Name);
                    }

                    if(!newList.contains(nomeJson)){
                        c.Name = (String) mapJson.get('Nome da Categoria');
                        c.Descricao__c = (String) mapJson.get('Descrição');
                        categorias.add(c);
                    }
                }
    
                if(categorias.size()> 0){
                    upsert categorias;
                    system.debug('Lista de categorias atualizada');
                }
            }
        }
    }