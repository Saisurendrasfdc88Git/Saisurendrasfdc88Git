@isTest
public class SCXVIIHandlerTest {

    // Test method for SCXVIIHandler.enforceContacts
    @isTest
    public static void testEnforceContacts() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        Account testAccount1 = new Account(Name = 'Test Account');
        insert testAccount1;

        Contact oldContact = new Contact(
            AccountId = testAccount.Id,
            LastName = 'Old Contact',
            Primary_Contact__c = true
        );
        insert oldContact;
        
        oldcontact.accountId =testAccount1.id;
        //oldcontact.LastName='saisurendra';
        update oldContact;
        
        
        //update oldContact;
       list<contact> conlist = new list<contact>();
        Contact newContact = new Contact();
            newContact.AccountId = testAccount.Id;
            newContact.LastName = 'New Contact';
            newContact.Primary_Contact__c = true;
        conlist.add(newContact);
        
        insert conlist;

        // Call the method to be tested
        Test.startTest();
        SCXVIIHandler.enforceContacts(conlist, new Map<Id, Contact>{oldContact.Id => oldContact});
        Test.stopTest();
        
        list<account> acclist = [select id,name from account];

        // Assert that the new contact has an error message
       /*List<Contact> updatedContacts = [SELECT Id, LastName, Primary_Contact__c FROM Contact WHERE Id = :conlist[0].Id];
        system.debug('updatedContacts.size()'+updatedContacts.size());
        System.assertEquals(1, updatedContacts.size());
        System.assertEquals('This account cannot have more than one primary contact', updatedContacts[0].LastName);*/
    }
}