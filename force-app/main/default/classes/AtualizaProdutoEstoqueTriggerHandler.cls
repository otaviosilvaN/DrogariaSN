public with sharing class AtualizaProdutoEstoqueTriggerHandler {
    public static void run(System.TriggerOperation triggerEvent) {
   
        switch on triggerEvent{

            when AFTER_INSERT{
                afterInsert();
            }
 
            when AFTER_UPDATE{
                afterUpdate();
            }
            
        }
        
    }
 
    private static void afterInsert(){
      
        ordens_de_venda__c ordens = (ordens_de_venda__c) trigger.new[0];
        List <Estoque__c> estoque = EstoqueDAO.getStockProductById(ordens.Mercadoria__c);
        List<Estoque__C> estoqueInsert = new List<Estoque__c>();
        
        for(Estoque__c e: estoque){
            // Verifica se já existe o produto no objeto estoque
            if(e.Mercadoria__c == ordens.Mercadoria__c){
                // Verifica se a quantidade solicitada está disponível no estoque
                if(ordens.Quantidade__c <= e.Estoque_atual__c){
                    e.Estoque_atual__c -= ordens.Quantidade__c;
                    // Após subtração do valor no estoque, o campo Status é classificado de acordo com o valor disponível e o estoque mínimo    
                    if(e.Estoque_atual__c <= e.Estoque_minimo__c ){
                        e.Status_do_estoque__c = 'Baixo';
                    }else{
                    e.Status_do_estoque__c = 'Normal';
                    }
                    // Caso a quantidade atualizada seja maior que o disponível em estoque, ele retornará a mensagem na tela 
                }else{
                    ordens.addError('Quantidade máxima no estoque: '+e.Estoque_atual__c + ' Unidades.');  
                }   
            }
            estoqueInsert.add(e);
        }
        update estoqueInsert;
    }

    private static void afterUpdate(){

    // A ideia deste método é que, quando eu precisar atualizar a quantidade do pedido, ele faça a atualização da forma correta
    // Devolvendo a quantidade anterior para o estoque e subtraindo novamente com a quantidade nova.
        
         // Recuperando a quantidade do pedido antes da atualização
        ordens_de_venda__c ordensOld = (ordens_de_venda__c) trigger.old[0];

        // Instanciando o objeto para atualização com dados novos
        ordens_de_venda__c ordensNew = (ordens_de_venda__c) trigger.New[0];


        // Atualizando os dados
        List <Estoque__c> estoque = EstoqueDAO.getStockProductById(ordensNew.Mercadoria__c);
        List<Estoque__c> estoqueOld = EstoqueDAO.getStockProductById(ordensNew.Mercadoria__c);
        List<Estoque__c> estoqueAtualizado = new List <Estoque__c>();

        for(Estoque__c e: estoque){
            // Atualizar o pedido no estoque quando a quantidade for alterada
            if(e.Mercadoria__c == ordensNew.Mercadoria__c){
                // Voltando com o produto do pedido para o estoque
                e.Estoque_atual__c += ordensOld.Quantidade__c;
                if(ordensNew.Quantidade__c <= e.Estoque_atual__c){ 
                    // Subtraindo a nova quantidade
                    e.Estoque_atual__c -= ordensNew.Quantidade__c;
                     // Devolvendo o produto para o estoque quando o pedido for cancelado
                    if (ordensNew.Status__c == 'Cancelado'){
                        e.Estoque_atual__c += ordensNew.Quantidade__c;
                    } 
                    // Atualizar a pickList Status do estoque
                    if(e.Estoque_atual__c <= e.Estoque_minimo__c ){
                        e.Status_do_estoque__c = 'Baixo';
                    } else{
                        e.Status_do_estoque__c = 'Normal';
                    }
                }else{
                    ordensNew.addError('Quantidade máxima no estoque: '+e.Estoque_atual__c + ' Unidades.');
                }
            }

            estoqueAtualizado.add(e);        
        }
        update estoqueAtualizado;
    
    }
               
}