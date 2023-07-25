@isTest
private class CalloutClassTest {
     @isTest static void testCallout() {
        // Set mock callout class //Check
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse res = CalloutClass.getInfoFromExternalService();
        ShakeCharity__c oShakeCharity = new ShakeCharity__c(EIN__c='20368066');
        insert oShakeCharity; 
        Test.startTest(); 
        SearchCharitydata.callAwsgateway(oShakeCharity.EIN__c);
        SearchCharitydata.callAwsgatewayOrgSearch(oShakeCharity.EIN__c);
        SearchCharitydata.createRecord(oShakeCharity.EIN__c); 
        
        Test.StopTest();
        // Verify response received contains fake values
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, res.getStatusCode());
    }
    
    @isTest static void testCalloutMethod() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorstring());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse res = CalloutClassforString.getInfoFromExternalService();
        ShakeCharity__c oShakeCharity = new ShakeCharity__c(EIN__c='20368066');
        insert oShakeCharity; 
        Test.startTest(); 
        SearchCharitydata.callAwsgatewayOrgSearch('American');
        Test.StopTest();
        // Verify response received contains fake values
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, res.getStatusCode());
    }
    
    @isTest static void testCalloutAWS() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse res = CalloutClass.getInfoFromExternalService();
        ShakeCharity__c oShakeCharity = new ShakeCharity__c(EIN__c='20368066');
        insert oShakeCharity; 
         Test.startTest(); 
         AWSCallout.callAwsgateway(oShakeCharity.EIN__c); 
         Test.StopTest();
        // Verify response received contains fake values
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, res.getStatusCode());
    }
}