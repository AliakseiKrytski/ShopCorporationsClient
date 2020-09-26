@isTest
private class AccountCallountsTest {
    @isTest static void testGetAccountByIdCallout() { 
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock()); 

        Test.startTest();
        Account resultAccount = AccountCallouts.makeGetAccountByIdCallout(AccountHttpCalloutMock.MOCK_TEST_ACCOUNT_ID);
        Test.stopTest();
     
        System.assert(resultAccount != null);
        System.assertEquals(AccountHttpCalloutMock.MOCK_TEST_ACCOUNT_ID, resultAccount.Id);
        System.assertEquals('Account1', resultAccount.Name);
    }

    @isTest static void testCreateAccountCallout() { 
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock()); 
        Account testAccount = new Account(
            Name='Funset test',
            Type='Prototype',
            AccountNumber='156486',
            Website='https://trailhead.salesforce.com',
            Phone='8494464');

        Test.startTest();
        Id resultAccountId = AccountCallouts.makeCreateAccountCallout(testAccount);
        Test.stopTest();
     
        System.assertEquals(AccountHttpCalloutMock.MOCK_TEST_ACCOUNT_ID, resultAccountId);
    }

    @isTest static void testDeleteAccountCallout() { 
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock()); 

        Test.startTest();
        // Posted Account ID is checking in the AccountHttpCalloutMock
        AccountCallouts.makeDeleteAccountCallout(AccountHttpCalloutMock.MOCK_TEST_ACCOUNT_ID);
        Test.stopTest();
    }

    @isTest static void testUpsertAccountCallout() { 
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock()); 
        Account changedAccount = new Account(
            Id=(String)AccountHttpCalloutMock.MOCK_TEST_ACCOUNT_ID,
            Name='Funset test',
            Type='Prototype',
            AccountNumber='444444');

        Test.startTest();
        Id changedAccountId = AccountCallouts.makeUpsertAccountCallout(changedAccount);
        Test.stopTest();
     
        System.assertEquals(AccountHttpCalloutMock.MOCK_TEST_ACCOUNT_ID, changedAccountId);
    }

    @isTest static void testUpdateAccountCallout() { 
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock()); 
        Account changedAccount = new Account(
            Id=(String)AccountHttpCalloutMock.MOCK_TEST_ACCOUNT_ID,
            Name='Funset test',
            Type='Prototype',
            AccountNumber='444444');

        Test.startTest();
        Id changedAccountId = AccountCallouts.makeUpdateAccountCallout(changedAccount);
        Test.stopTest();
     
        System.assertEquals(AccountHttpCalloutMock.MOCK_TEST_ACCOUNT_ID, changedAccountId);
    }
}
