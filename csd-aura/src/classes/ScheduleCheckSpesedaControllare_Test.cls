/**
* @desc           Test Class for ScheduleCheckSpesedaControllare
* @author         Renato Mazzola   (renato.mazzola@enel.com)
* @date           July, 2021
**/

@isTest
public class ScheduleCheckSpesedaControllare_Test {
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
        //Create new TimeManagement record
        Time_Management__c tmte = new Time_Management__c(Dipendente__c = newDipendente.Id,
                                                         RecordTypeId = RecordTypeId,
                                                         Status__c = 'Pending', Costo__c = 34,
                                                         Spesa_da_Autorizzare__c = false,
                                                         Note__c = 'Test');
        insert tmte;
    }
    
	@isTest
    public static void testScheduledJob() {
        String CRON_EXP = '0 0 0 3 9 ? 2022';
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduleCheckSpesedaControllare_Test', CRON_EXP, new ScheduleCheckSpesedaControllare());
        // After a class has been scheduled, a CronTrigger object is created that represents the scheduled job
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId]; 
        Time_Management__c tmte = [SELECT Id, Status__c FROM Time_Management__c LIMIT 1];
        System.assertEquals(0, ct.TimesTriggered); 
        System.assertEquals('2022-09-03 00:00:00', String.valueOf(ct.NextFireTime));
        Test.stopTest();
    }        
}