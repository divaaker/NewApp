@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        //System.assertEquals('https://agbg6e5ci7.execute-api.us-east-2.amazonaws.com/CharityBeta/charitydata/20368066', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        string sBody = '{"Item":{"SORT_NAME":"6213 OYSTER RIVER PARAPROFESSIONALS\r","INCOME_CD":"0","CITY":"DURHAM","ASSET_AMT":"0","AFFILIATION":"9","EIN":"10785529","STREET":"25 WOODRIDGE RD","CLASSIFICATION":"3000","ORGANIZATION":"5","REVENUE_AMT":"0","SUBSECTION":"5","ICO":"% KIMBERLY MCNAMARA","INCOME_AMT":"0","ASSET_CD":"0","TAX_PERIOD":"201806","RULING":"196711","ZIP":"03824-2917","DEDUCTIBILITY":"2","ACTIVITY":"263264279","FILING_REQ_CD":"2","OrgNAME":"AMERICAN FEDERATION OF TEACHERS","FOUNDATION":"0","NTEE_CD":"Null","STATUS":"1","PF_FILING_REQ_CD":"0","ACCT_PD":"6","STATE":"NH"}}';
        res.setBody(sBody.replaceAll('\n','').replaceAll('\r',''));
        res.setStatusCode(200);
        return res;
    }
}