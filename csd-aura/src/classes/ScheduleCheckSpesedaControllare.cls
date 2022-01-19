/**
   * @desc           Schedule Job to update 'Status__c' of Time_Management__c records
   * @author         Renato Mazzola   (renato.mazzola@enel.com)
   * @date           July, 2021
   **/

global class ScheduleCheckSpesedaControllare implements Schedulable {
    global void execute(SchedulableContext ctx) {
        Id tmRecordType = Schema.SObjectType.Time_Management__c.getRecordTypeInfosByName().get('Nota Spese').getRecordTypeId();
        
        List<Time_Management__c> tmteList = [SELECT Id, RecordTypeId, Spesa_da_Autorizzare__c, Status__c
                                             FROM Time_Management__c];
        
        if(!tmteList.isEmpty()){
            for(Time_Management__c  SpeseRecord : tmteList){
                if(SpeseRecord.Spesa_da_Autorizzare__c == false &&
                   SpeseRecord.RecordTypeId == tmRecordType &&
                   SpeseRecord.Status__c == 'Pending') SpeseRecord.Status__c = 'Complete';
            }
            update tmteList;
        }
    }
}