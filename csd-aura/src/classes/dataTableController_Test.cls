/**
* @desc           Test Class for dataTableController
* @author         Renato Mazzola   (renato.mazzola@enel.com)
* @date           July, 2021
**/

@isTest
public class dataTableController_Test {
    @testSetup
    static void setup(){
        //Create new User
        User testUser = testDataFactory.createNewUser();
        insert testUser;
        //Create Dipendente__c
        Dipendente__c newDipendente = testDataFactory.createNewDipendente(testUser.Id);
        insert newDipendente;
        //Get RecordTypeId from RecordTypeName
        Id RecordTypeId = Schema.SObjectType.Time_management__c.getRecordTypeInfosByName().get('Nota Spese').getRecordTypeId();
        //Create new TimeManagement record with Costo__c >100
        Time_Management__c  speseRecord = new Time_Management__c(Dipendente__c = newDipendente.Id,
                                                                 RecordTypeId = RecordTypeId,
                                                                 Costo__c = 101,
                                                                 Note__c = 'Test');
        
        insert speseRecord;   
    }
    
    static testmethod void getobjectAndField_Test(){
        String obj = 'Time_Management__c';
        String fields = 'Id,Name,Note__c,Costo__c,RecordTypeId,Spesa_da_Autorizzare__c,Status__c,Dipendente__c';
        String recordType = 'Nota Spese';
   
        Dipendente__c dipendenteTest = [SELECT Id, Name FROM Dipendente__c LIMIT 1];
        Time_Management__c tmte = [SELECT Id,RecordTypeId,Costo__c,Note__c,Spesa_da_Autorizzare__c, Dipendente__c FROM Time_Management__c LIMIT 1];
        test.startTest();
        List<Time_Management__c> tmteList = dataTableController.getObjectAndFields(obj,fields,recordType);
        System.assertEquals( dipendenteTest.Id, tmteList[0].Dipendente__c);
        //test the recordType null condition 
        List<Time_Management__c> tmteList2 = dataTableController.getObjectAndFields(obj,fields, null);
        System.assertEquals(!tmteList2.isEmpty(), true);
        test.stopTest();
    }
    
    static testmethod void deleteRecord_Test(){
        Dipendente__c dipendenteTest = [SELECT Id, Name FROM Dipendente__c LIMIT 1];
        Time_Management__c tmte2 = [SELECT Id FROM Time_Management__c LIMIT 1];
        
        List<Id> tmteList = new List<Id>();
        tmteList.add(tmte2.Id);
        Test.startTest();
        dataTableController.deleteRecord(tmteList);
        System.assertEquals([SELECT Id FROM Time_Management__c].isEmpty(), true);
        Test.stopTest();
    }
    
    static testmethod void getURL_Test(){
        Test.startTest();
        string url = dataTableController.getURL();
        Test.stopTest();
    }
}