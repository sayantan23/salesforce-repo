@IsTest
private class BookingInvokerTest {

    @TestSetup
    static void makeData(){

        Account acc = new Account();
        acc.Name = 'TestAccount';
        acc.Phone = '+4917629807593';
        acc.ClearingHouse__c = 'GMBH';
        acc.LiableOffice__c = 'HAMBURG';
        acc.SalesTeam__c = 'FINANCE';
        acc.BookingType__c = 'NEW_BUSINESS';
        acc.BillingTerms__c = 'NET_10';
        acc.SalesChannel__c = 'WEBINAR';
        acc.AccessType__c = 'DOMAIN';
        insert acc;

        Contact con = new Contact();
        con.FirstName = 'Sayantan';
        con.LastName = 'Bhattacharya';
        con.Gender__c = 'MALE';
        con.AccountId = acc.Id;
        con.Phone = '+4917629807593';
        con.Email = 'sayantan.sb@gmail.com';
        con.MailingCountry = 'DE';
        con.MailingCity = 'Berlin';
        con.MailingPostalCode = '13581';
        con.MailingStreet = 'Brunsbütteler Damm';
        con.HouseNumber__c = '223D';
        insert con;

        Opportunity opp = new Opportunity();
        opp.Name = 'My Great Opportunity';
        opp.StageName = 'Closed Won';
        opp.CloseDate = System.today();
        opp.AgreementForm__c = 'CONTRACT';
        opp.DealType__c = 'SINGLE';
        opp.RequestorId__c = 100;
        opp.AccountId = acc.Id;
        insert opp;

        RevenueShare__c revShare = new RevenueShare__c();
        revShare.TotalShareValue__c = 100.00;
        revShare.TotalShareInPercent__c = 50;
        revShare.SalesManagerId__c = 10123;
        revShare.ProfitCenter__c = 'ASIA';
        revShare.Opportunity__c = opp.Id;
        insert revShare;

        RevenueShare__c revShareOther = new RevenueShare__c();
        revShareOther.TotalShareValue__c = 100.00;
        revShareOther.TotalShareInPercent__c = 50;
        revShareOther.SalesManagerId__c = 10124;
        revShareOther.ProfitCenter__c = 'DACH_EU';
        revShareOther.Opportunity__c = opp.Id;
        insert revShareOther;

        FeatureProduct__c featureProduct = new FeatureProduct__c();
        featureProduct.Type__c = 'PREMIUM_ACCOUNT';
        featureProduct.Price__c = 125.00;
        featureProduct.PricePerMonth__c = 10.5;
        featureProduct.description__c = 'Test Description';
        featureProduct.Opportunity__c = opp.Id;
        insert featureProduct;

        
    }

    @IsTest
    static void testInvokePostStatusChangedBooking(){

        List<Opportunity> opps = [select Id from Opportunity];
        List<Id> oppIds = new List<Id>();
        for(Opportunity o: opps){
            oppIds.add(o.Id);
        }
        


        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        BookingInvoker.invokePostStatusChangedBooking(oppIds);
        



    }
    
}