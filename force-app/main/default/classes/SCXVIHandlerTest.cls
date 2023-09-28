//SAISURENDRA SESHAPU
@isTest
public class SCXVIHandlerTest {  
    @isTest
    public static void testSCXVI() {
        // Create and insert test accounts
        Account testAccount1 = new Account(Name = 'Test Account 1');
        insert testAccount1;

        Account testAccount2 = new Account(Name = 'Test Account 2');
        insert testAccount2;

        // Create and insert an opportunity associated with testAccount1
        Opportunity oldOpp = new Opportunity(
            Name = 'Sai',
            Amount = 500000,
            StageName = 'Prospect',
            CloseDate = System.today(),
            AccountId = testAccount1.Id
        );
        insert oldOpp;

        // Update and delete oldOpp
        oldOpp.AccountId = testAccount2.Id;
        update oldOpp;
        oldOpp.Name = 'saisurendra';
        update oldOpp;
        delete oldOpp;

        // Create new opportunities associated with testAccount1 and testAccount2
        Opportunity Opp1 = new Opportunity(
            Name = 'Sai1',
            Amount = 400000,
            StageName = 'Prospect',
            CloseDate = System.today(),
            AccountId = testAccount1.Id
        );
        Opportunity Opp2 = new Opportunity(
            Name = 'Sai2',
            Amount = 600000,
            StageName = 'Prospect',
            CloseDate = System.today(),
            AccountId = testAccount2.Id
        );

        List<Opportunity> newOpportunities = new List<Opportunity>{Opp1, Opp2};
        insert newOpportunities;

        Map<Id, Opportunity> MapOpp = new Map<Id, Opportunity> {oldOpp.Id => oldOpp};

        Test.startTest();
        SCXVIHandler.HighestOpp(newOpportunities, MapOpp);
        Test.stopTest();

        // Verify the Max_Opp__c field on testAccount1 and testAccount2
        Account updatedAccount1 = [SELECT Id, Max_Opp__c FROM Account WHERE Id = :testAccount1.Id];
        System.assertEquals('Sai1', updatedAccount1.Max_Opp__c);

        Account updatedAccount2 = [SELECT Id, Max_Opp__c FROM Account WHERE Id = :testAccount2.Id];
        System.assertEquals('Sai2', updatedAccount2.Max_Opp__c);
    }
}