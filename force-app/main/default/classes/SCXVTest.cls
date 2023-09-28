@isTest
public class SCXVTest {

    @isTest
    static void testGetSalary() {
        // Create test data
        Account testAccount1 = new Account(Name = 'Test Account 1');
        insert testAccount1;

        Account testAccount2 = new Account(Name = 'Test Account 2');
        insert testAccount2;

        Contact oldContact = new Contact(lastname='sai',AccountId = testAccount1.Id, Salary__c = 50000);
        insert oldContact;
        
        oldContact.AccountId=testAccount2.id;
        update oldContact;
        
        oldContact.LastName='Saisurendra';
        update oldContact;

        Contact newContact1 = new Contact(lastname='sai',AccountId = testAccount1.Id, Salary__c = 60000);
        Contact newContact2 = new Contact(lastname='sai',AccountId = testAccount2.Id, Salary__c = 55000);
        
        List<Contact> newContacts = new List<Contact>{newContact1, newContact2};
            insert newcontacts;
        Map<Id, Contact> oldContacts = new Map<Id, Contact>{oldContact.Id => oldContact};

        // Call the method to test
        Test.startTest();
        SCXV.getSalary(newContacts, oldContacts);
        Test.stopTest();

        // Verify the results
        Account updatedAccount1 = [SELECT Id, Max_Salary__c, Min_Salary__c FROM Account WHERE Id = :testAccount1.Id];
        Account updatedAccount2 = [SELECT Id, Max_Salary__c, Min_Salary__c FROM Account WHERE Id = :testAccount2.Id];

        System.assertEquals(60000, updatedAccount1.Max_Salary__c);
        System.assertEquals(50000, updatedAccount1.Min_Salary__c);

        System.assertEquals(55000, updatedAccount2.Max_Salary__c);
        System.assertEquals(55000, updatedAccount2.Min_Salary__c);
    }
}