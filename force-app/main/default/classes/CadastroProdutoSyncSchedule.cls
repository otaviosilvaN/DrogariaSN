global with sharing class CadastroProdutoSyncSchedule implements Schedulable{
    // implement scheduled code here
    global void execute(SchedulableContext sc){
        System.enqueueJob(new CadastroProdutoCalloutService());
    }
}