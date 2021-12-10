@isTest
public class testDataFactory {
    public static user createNewUser(){
        Id profileId =[SELECT Id FROM Profile WHERE Name = 'System Administrator' or Name = 'Amministratore del sistema' LIMIT 1][0].Id;
        User testUser = new User();
        testUser.alias = 'Testt';
        testUser.email = 'test@test.com';
        testUser.emailencodingkey = 'UTF-8';
        testUser.lastname = 'testUser';
        testUser.languagelocalekey = 'en_US';
        testUser.localesidkey = 'it_IT';
        testUser.username = 'User' + Datetime.now().getTime() + '@test.com';
        testUser.timezonesidkey = 'America/Los_Angeles';
        testUser.profileid = profileId;
        return testUser;
        }
    
        public static Dipendente__c createNewDipendente(Id userId){
            Dipendente__c newDipendente = new Dipendente__c();
            newDipendente.Name = 'TestDipendente';
            newDipendente.User__c = userId;
            return newDipendente;
        }
    }