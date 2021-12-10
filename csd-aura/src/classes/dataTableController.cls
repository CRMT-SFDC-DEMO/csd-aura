/**
   * @desc           'genericDataTable' LWC controller
   * @author         Renato Mazzola   (renato.mazzola@enel.com)
   * @date           July, 2021
   **/

public with sharing class dataTableController {

    /**
    * @desc           Get Object and Fields from genericDataTable Design Attribute
    * @author         Renato Mazzola   (renato.mazzola@enel.com)
    * @date           July, 2021
    * @param          String obj : sObject, String fields : list of comma-separated fields, String recordType: recordType
    **/

    @AuraEnabled
    public static List<sObject> getObjectAndFields (String obj, String fields, String recordType){
        List<sObject> sobjList = new  List<sObject>();
        if(recordType != null) sobjList = Database.query('SELECT ' +fields +' FROM ' +obj+ ' WHERE RecordType.Name = \'' + recordType + '\'' + ' ORDER BY CreatedDate DESC');
        else if(recordType == null) sobjList = Database.query('SELECT ' +fields +' FROM ' +obj+ ' ORDER BY CreatedDate DESC');
        return sobjList;
    }

    /**
    * @desc           delete record
    * @author         Renato Mazzola   (renato.mazzola@enel.com)
    * @date           July, 2021
    * @param          List<Id> recordIds : id Time_Management__c records
    **/

    @AuraEnabled
    public static void deleteRecord(List<Id> recordIds){
            List<sObject> recordToDelete = new List <sObject>();
            for(Id idRecord : recordIds){
                sObject q = idRecord.getSobjectType().newSobject(idRecord);
                recordToDelete.add(q);
            }
            if(!recordIds.isEmpty()){
                delete recordToDelete;
            }
    }

    /**
    * @desc           create Link to the record
    * @author         Renato Mazzola   (renato.mazzola@enel.com)
    * @date           July, 2021
    **/

    @AuraEnabled
    public static String getURL(){
       List<Environment__c> urls = [SELECT Current_Domain__c FROM Environment__c];
       return !urls.isEmpty() ? urls[0].Current_Domain__c : null;

    }
}