@isTest
public class auraCreateRecordsController_Test {
	@testSetup
    static void setup(){
        //Create new User
        User testUser = testDataFactory.createNewUser();
        insert testUser;
        //Create Dipendente__c
        Dipendente__c newDipendente = testDataFactory.createNewDipendente(testUser.Id);
        insert newDipendente;
        //Create new TimeManagement record with Costo__c >100
        Time_Management__c  speseRecord = new Time_Management__c(Dipendente__c = newDipendente.Id,
                                                                 Costo__c = 101,
                                                                 Note__c = 'Test');
        
        insert speseRecord;   
    }
    
    static testmethod void getRecordTypeId(){
        Time_Management__c recordTest = [SELECT Id,RecordTypeId,RecordType.Name FROM Time_Management__c LIMIT 1];
        test.startTest();
        id recordTypeIdTest = auraCreateRecordsController.getRecordTypeId(recordTest.RecordType.Name);
        System.assertEquals( recordTest.RecordTypeId, recordTypeIdTest);
        test.stopTest();
    }
}