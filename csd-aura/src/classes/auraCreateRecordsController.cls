public with sharing class auraCreateRecordsController {

    @AuraEnabled
    public static Id getRecordTypeId (String recordType){
        Id RecordTypeId = Schema.SObjectType.Time_management__c.getRecordTypeInfosByName().get(recordType).getRecordTypeId();
        return RecordTypeId;
    }


}