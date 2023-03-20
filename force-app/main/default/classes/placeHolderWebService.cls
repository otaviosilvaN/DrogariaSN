public class placeHolderWebService{

    @InvocableMethod
    public static void calloutService(List<String> listEan) {
    // O método irá receber sempr euma lista de Id de produto vinda do SalesForce.

        String endpoint, accessToken, ean;
        //Acessando produtos do banco de dados
        List<Mercadorias__c> productList = [SELECT Id, Name, EAN__C, Descricao__c FROM Mercadorias__c WHERE EAN__C IN :listEan];
        // Armazenando o EAN do produto que será chamado na Integração, que no momento está sendo feita uma por uma 
        for(Mercadorias__c p : productList){
            ean  = p.EAN__C;
        }
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        // Acessando dados de integração/autenticação nos metadados criados
        Map<String, Integracao_Lett__mdt> mapIt = Integracao_Lett__mdt.getAll();
        for(String domain: mapIt.keySet()){
            endpoint = mapIt.get(domain).endpoint__c;
            accessToken = mapIt.get(domain).access_token__c;
        }

        system.debug('ENDPOINT '+ endpoint);
        System.debug('ACCESSTOKEN '+accessToken);
        request.setMethod('GET');
        // A busca na API está sendo feita para chamar o Produto relativo ao que foi cadastrado no SalesForce
        request.setEndpoint(endpoint+ '?ean[]='+ean);
        request.setHeader('Authorization','Bearer '+accessToken);
        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 202 || response.getStatusCode() == 200){
            System.debug('Integração Feita com sucesso! '+ response.toString()+ '. Status do response: '+response.getStatus());

            // Desserialização do JSON de response via classe TO
            String body = response.getBody();
            system.debug('DEBUG DO BODY : '+ body);
            lettIntegrationTO prodTO = lettIntegrationTO.parse(body);

            // Mapeamento dos campos
            String titulo;
            String descricao;
            List<String> listUrlPrimaria;
            List<String> listUrlSecundaria;
            
            List<Mercadorias__c> produtos = new List<Mercadorias__c>();

            for(lettIntegrationTO.ProductTOLett prod: prodTO.data){
                titulo = prod.attributes.name;
                descricao = prod.attributes.description ;
                listUrlPrimaria = prod.attributes.pic_primary.original;
                listUrlSecundaria = prod.attributes.pic_secondary.original;
            }

            String imagemPrimariaConcatenada = '';
            String imagemSecundariaConcatenada = '';
            Imagem_produto__c  objImg = new Imagem_produto__c ();
            for(Mercadorias__c newList: productList ){

                if( titulo != newList.Name || descricao  != newList.Descricao__c){
                    newList.Name = titulo;
                    newList.Descricao_Integracao__c = descricao;
                    // Vinculando o objeto ImagemProduto a esse produto
                    objImg.Mercadoria__c = newList.Id;
                    produtos.add(newList);
                    
                    for(String p: listUrlPrimaria){
                        imagemPrimariaConcatenada +='<img src="'+p+'" />';
                        system.debug('DEBUG DA IMAGEM PRIMÁRIA - '+p);

                    }

                    for(String p: listUrlSecundaria){
                        //system.debug('debug lista url sec - '+lista);
                        imagemSecundariaConcatenada += '<img src="'+p+'" />';
                        system.debug('DEBUG DA IMAGEM SECUNDÁRIA - '+p);
                    }

                    //newList.Imagem_produto__c = imagemConcatenada;
                    // Será adicionada uma imagem no sistema através de URL
                   
                }
            }

            //Anexando informaçoes no objeto Imagem do produto
            system.debug('DEBUG IMAGEM PRIMARIA - '+imagemPrimariaConcatenada);
            system.debug('DEBUG IMAGEM SECUNDÁRIA - '+imagemSecundariaConcatenada);

            // Atribuindo as imagens do produto ao objeto Imagem do Produto
            objImg.Imagem_primaria__c = imagemPrimariaConcatenada;
            objImg.Imagem_secundaria__c = imagemSecundariaConcatenada;
            insert objImg;

            system.debug('Imagem do produto criada! ');

            // Inserção/ atualização de informações no registro de campo
            if(!produtos.isEmpty()){
                Database.upsert(produtos);
            }

        }else{
            system.debug('Erro na Integração: ' + response.toString() + '. Status Do response: ' + response.getStatus());
        }
    }
    
}