global class SearchCharitydata {
    @AuraEnabled
    public static List<wrapperClass> callAwsgateway(string EIN) {
        wrapperClass returnwrapperClass = new  wrapperClass (); 
        List<wrapperClass> lstWrapper = new List<wrapperClass>(); 
        Http http = new Http();
         List<Account> UpdateAcc = new List<Account>();
        system.debug('EIN====='+EIN );
        EIN = EIN.replace('-', '');
        string sEndPoint = 'https://agbg6e5ci7.execute-api.us-east-2.amazonaws.com/CharityBeta/charitydata/'+EIN;
        HttpRequest request = new HttpRequest();

        //Please set the endpoint of API gateway which we are going to create in later section
        request.setEndpoint(sEndPoint);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');

        // Set the body as a JSON object
        HttpResponse response = http.send(request);
        System.debug('response==='+response.getBody());
        String body;
        JSONParser parser = JSON.createParser(response.getBody());
        system.debug(parser );
        system.debug(parser.nextToken());
        system.debug(parser.getCurrentToken());

        if(parser.getCurrentToken() == JSONToken.START_OBJECT) {
            parser.nextValue();
            system.debug(parser.getCurrentName());
            parser.nextValue();
            system.debug(parser.getCurrentName());
            if(parser.getCurrentName() == 'SORT_NAME') {
                returnwrapperClass.sSortName = parser.getText();
                parser.nextValue();
            } 
            if (parser.getCurrentName() == 'INCOME_CD') {
                parser.nextValue();
            } 

            if (parser.getCurrentName() == 'CITY') {
                system.debug(parser.getText() );
                returnwrapperClass.sCity=parser.getText() ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'ASSET_AMT') {
                system.debug(parser.getText() );
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'AFFILIATION') {
                system.debug(parser.getText() );
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'EIN') {
                system.debug(parser.getText() );
                returnwrapperClass.sEIN=parser.getText() ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'STREET') {
                system.debug(parser.getText() );
                returnwrapperClass.sStreet=parser.getText() ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'CLASSIFICATION') {
                system.debug(parser.getText() );
                parser.nextValue();
            } 

            if (parser.getCurrentName() == 'ORGANIZATION') {
                system.debug(parser.getText() );
                parser.nextValue();
            } 

            if (parser.getCurrentName() == 'REVENUE_AMT') {
                system.debug(parser.getText() );
                parser.nextValue();
            } 

            if (parser.getCurrentName() == 'SUBSECTION') {
                system.debug(parser.getText() );
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'ICO') {
                system.debug(parser.getText() );
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'INCOME_AMT') {
                system.debug(parser.getText() );
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'ASSET_CD') {
                system.debug(parser.getText() );
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'TAX_PERIOD') {
                system.debug(parser.getText() );
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'RULING') {
                system.debug(parser.getText() );
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'ZIP') {
                system.debug(parser.getText() );
                returnwrapperClass.sZip=parser.getText() ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'DEDUCTIBILITY') {
                system.debug(parser.getText() );
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'ACTIVITY') {
                system.debug(parser.getText() );
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'FILING_REQ_CD') {
                system.debug(parser.getText() );
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'OrgNAME') {
                system.debug(parser.getText() );
                returnwrapperClass.sName=parser.getText() ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'FOUNDATION') {
                system.debug(parser.getText() );
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'NTEE_CD') {
                system.debug(parser.getText() );
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'STATUS') {
                system.debug(parser.getText() );
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'PF_FILING_REQ_CD') {
                system.debug(parser.getText() );
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'ACCT_PD') {
                system.debug(parser.getText() );
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'STATE') {
                system.debug(parser.getText() );
                returnwrapperClass.sState=parser.getText() ;
                parser.nextValue();
            }
        }  
        List<ShakeCharity__c> lstShakeCharity = [SELECT Id, Name FROM ShakeCharity__c WHERE EIN__c=:EIN LIMIT 1];
        if(lstShakeCharity.size()>0 && lstShakeCharity != null){ 
            returnwrapperClass.sExist = true;
            returnwrapperClass.sRecordID = lstShakeCharity[0].Id;
        }

        // Parse the JSON response
        if (response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
            response.getStatusCode() + ' ' + response.getStatus());

        }

        else {
            System.debug(response.getBody());

        }
        lstWrapper.add(returnwrapperClass);
        system.debug(lstWrapper.size());
        return lstWrapper;
    }
    
    @AuraEnabled
    public static List<wrapperClass> callAwsgatewayOrgSearch(string EIN) {
        map<string,Id> mapAcc = new map<string,Id>();
        EIN = EIN.replace('-', '');
        system.debug(EIN.length());
        List<ShakeCharity__c> lstShakeCharity = [SELECT Id, EIN__c FROM ShakeCharity__c WHERE EIN__c != null];
        if(lstShakeCharity != null && lstShakeCharity.size()>0){
            for(ShakeCharity__c oShakeCharity : lstShakeCharity){
                mapAcc.put(oShakeCharity.EIN__c,oShakeCharity.Id);
            }
        }
        system.debug(mapAcc);
        set<wrapperClass> lstWrapper = new set<wrapperClass>(); 
        Http http = new Http();
        HttpResponse response;
        List<ShakeCharity__c> updateShakeCharity = new List<ShakeCharity__c>();
        if(EIN.isNumeric()){
          	system.debug('EIN====='+EIN );
            string sEndPoint = 'https://agbg6e5ci7.execute-api.us-east-2.amazonaws.com/CharityBeta/charitydata/'+EIN;
            HttpRequest request = new HttpRequest();
    
            //Please set the endpoint of API gateway which we are going to create in later section
            request.setEndpoint(sEndPoint);
            request.setMethod('GET');
            request.setHeader('Content-Type', 'application/json');
    
            // Set the body as a JSON object
            response = http.send(request);
            if(response != null){
            	System.debug('response123==='+response.getBody());    
            }
            else{
            	System.debug('response==='+response.getBody());    
            }
            
            String body;
            JSONParser parser = JSON.createParser(response.getBody());
            
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody().replaceAll('\n','').replaceAll('\r',''));
            system.debug(results);
            Map<String, Object> data = (Map<String, Object>)results.get('Item');
            system.debug(data.keySet());
            for(String key : data.keySet()){
                System.debug('### lines.get(key) : ' + data.get('SORT_NAME'));
                System.debug('### >>> ' + data.get(key));
                wrapperClass returnwrapperClass = new  wrapperClass ();
                  returnwrapperClass.sSortName  = string.valueof(data.get('OrgNAME'));
                    returnwrapperClass.sCity  = string.valueof(data.get('CITY'));
                    returnwrapperClass.sEIN  = string.valueof(data.get('EIN'));
                    returnwrapperClass.sZip  = string.valueof(data.get('ZIP'));
                    returnwrapperClass.sSTATE  = string.valueof(data.get('STATE'));
                    returnwrapperClass.sName  = string.valueof(data.get('OrgNAME'));
                    returnwrapperClass.sStreet  = string.valueof(data.get('STREET'));
                    Object oEIN = mapAcc.get(string.valueof(data.get('EIN')));
                    if(oEIN != null){
                        returnwrapperClass.sExist = true;
                        returnwrapperClass.sIsSalesforce = true;
                        returnwrapperClass.sRecordID = mapAcc.get(string.valueof(data.get('EIN')));
                    }
                    lstWrapper.add(returnwrapperClass);
                    System.debug(lstWrapper);
                break;
            }  
        }

        else{
          system.debug('EIN====='+EIN );
            String sEIN= '%'+EIN+'%';
            system.debug(sEIN);
            List<Account> lstAccount = [SELECT id, EIN__c, Name, BillingCity, BillingState, BillingStreet, BillingPostalCode  FROM Account WHERE Name like: sEIN];
            if(lstAccount != null && lstAccount.size()>0){
                for(Account oAcc : lstAccount){
                    if(!oAcc.Name.contains('Household')){
                        wrapperClass returnwrapperClass = new  wrapperClass ();
                        returnwrapperClass.sSortName  = oAcc.Name;
                        returnwrapperClass.sEIN  = oAcc.EIN__c;
                        returnwrapperClass.sName  = oAcc.Name;
                        returnwrapperClass.sCity  = oAcc.BillingCity;
                        returnwrapperClass.sSTATE  = oAcc.BillingState;
                        returnwrapperClass.sZip  =  oAcc.BillingPostalCode;
                        returnwrapperClass.sStreet  =  oAcc.BillingStreet;
                        returnwrapperClass.sExist = true;
                        returnwrapperClass.sIsSalesforce = true;
                        returnwrapperClass.sRecordID = oAcc.Id;
                        lstWrapper.add(returnwrapperClass);    
                    }
                }
            }
            EIN = EIN.toUppercase();
            string sEndPoint = 'https://3k0fpzhw53.execute-api.us-east-2.amazonaws.com/Pro/charitydata/'+EIN;
            HttpRequest request = new HttpRequest();
    
            //Please set the endpoint of API gateway which we are going to create in later section
            request.setEndpoint(sEndPoint);
            request.setMethod('GET');
            request.setHeader('Content-Type', 'application/json');
    
            // Set the body as a JSON object
            response = http.send(request);
            System.debug('response==='+response.getBody());
            //String body;
            JSONParser parser = JSON.createParser(response.getBody());
            String body = response.getBody();
            system.debug(body);
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            List<Object> lstCustomers = (List<Object>)results.get('Items');
            Object[] aryCustomers = (Object[]) results.get('Items');
            system.debug('results===='+results);
            system.debug('lstCustomers===='+lstCustomers);
            system.debug('aryCustomers===='+aryCustomers);
            for (Object customer : lstCustomers) {
                Map<String, Object> customerAttributes = (Map<String, Object>)customer;
                wrapperClass returnwrapperClass = new  wrapperClass ();
                    // handle response
                    returnwrapperClass.sSortName  = string.valueof(customerAttributes.get('OrgNAME'));
                    returnwrapperClass.sCity  = string.valueof(customerAttributes.get('CITY'));
                    returnwrapperClass.sEIN  = string.valueof(customerAttributes.get('EIN'));
                    returnwrapperClass.sZip  = string.valueof(customerAttributes.get('ZIP'));
                    returnwrapperClass.sSTATE  = string.valueof(customerAttributes.get('STATE'));
                    returnwrapperClass.sName  = string.valueof(customerAttributes.get('OrgNAME'));
                    returnwrapperClass.sStreet  = string.valueof(customerAttributes.get('STREET'));
                    Object oEIN = mapAcc.get(string.valueof(customerAttributes.get('EIN')));
                    if(oEIN != null){
                        returnwrapperClass.sExist = true;
                        returnwrapperClass.sIsSalesforce = true;
                        returnwrapperClass.sRecordID = mapAcc.get(string.valueof(customerAttributes.get('EIN')));
                    }
                    lstWrapper.add(returnwrapperClass);
                    System.debug(lstWrapper);
                } 
            }
        
        // Parse the JSON response
        if (response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
            response.getStatusCode() + ' ' + response.getStatus());

        } else {
            System.debug(response.getBody());

        }
        List<wrapperClass> listwrap = new List<wrapperClass>(lstWrapper);
        return listwrap;
    }
    
    // wrapper or Inner class with @AuraEnabled {get;set;} properties*    
    public class wrapperClass{
        @AuraEnabled public String sSortName {get;set;}
        @AuraEnabled public String sName {get;set;}
        @AuraEnabled public String sCity {get;set;}
        @AuraEnabled public String sState {get;set;}
        @AuraEnabled public String sEIN {get;set;}
        @AuraEnabled public String sStreet {get;set;}
        @AuraEnabled public String sZip {get;set;}
        @AuraEnabled public boolean sExist {get;set;}
        @AuraEnabled public string sRecordID {get;set;}
        @AuraEnabled public string sResponse {get;set;}
        @AuraEnabled public boolean sIsSalesforce {get;set;}
        @AuraEnabled public string sCharityRecord {get;set;}
        public wrapperClass(){  
        }
    }
  
  public class OrgData{
        @AuraEnabled public String sSortName1 {get;set;}
        @AuraEnabled public String sName1 {get;set;}
        @AuraEnabled public String sCity1 {get;set;}
        @AuraEnabled public String sState1 {get;set;}
        @AuraEnabled public String sEIN1 {get;set;}
        @AuraEnabled public String sStreet1 {get;set;}
        @AuraEnabled public String sZip1 {get;set;}
        public OrgData(String sSortName1, String sName1, String sCity1, String sState1, String sEIN1,  String sStreet1, String sZip1){
            this.sSortName1 = sSortName1;
            this.sName1 = sName1;
            this.sCity1 = sCity1;
            this.sState1 = sState1;
            this.sEIN1 = sEIN1;
            this.sStreet1 = sStreet1;
            this.sZip1 = sZip1;   
        }
    }
    
    @AuraEnabled
    public static List<ShakeCharity__c> createRecord(string EIN) {
        string sAccountId;
        Http http = new Http();
        List<ShakeCharity__c> createShakeCharity = new List<ShakeCharity__c>();
        system.debug('EIN====='+EIN );
        EIN = EIN.replace('-', '');
        string sEndPoint = 'https://agbg6e5ci7.execute-api.us-east-2.amazonaws.com/CharityBeta/charitydata/'+EIN;
        HttpRequest request = new HttpRequest();

        //Please set the endpoint of API gateway which we are going to create in later section
        request.setEndpoint(sEndPoint);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');

        // Set the body as a JSON object
        HttpResponse response = http.send(request);
        System.debug('response==='+response.getBody());
        String body;
        JSONParser parser = JSON.createParser(response.getBody());
        system.debug(parser );
        system.debug(parser.nextToken());
        system.debug(parser.getCurrentToken());
        
        List<Account> oAccount = [SELECT Id FROM Account WHERE EIN__c =:EIN LIMIT 1];
        if(oAccount.size() >0){
        	sAccountId = oAccount[0].Id;     
        }
        Account newAcc = new Account();
        ShakeCharity__c oShakeCharity = new ShakeCharity__c();
        if(parser.getCurrentToken() == JSONToken.START_OBJECT) {
            parser.nextValue();
            system.debug(parser.getCurrentName());
            parser.nextValue();
            system.debug(parser.getCurrentName());
            if(parser.getCurrentName() == 'SORT_NAME') {
                system.debug(parser.getText() );
                parser.nextValue();
            } 

            if (parser.getCurrentName() == 'INCOME_CD') {
                system.debug(parser.getText() );
                oShakeCharity.Income_CD__c=parser.getText() ;
                parser.nextValue();
            } 

            if (parser.getCurrentName() == 'CITY') {
                system.debug(parser.getText() );
                oShakeCharity.Billing_City__c=parser.getText() ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'ASSET_AMT') {
                system.debug(parser.getText() );
                oShakeCharity.Asset_AMT__c=parser.getText() ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'AFFILIATION') {
                system.debug(parser.getText() );
				oShakeCharity.Affiliation__c=parser.getText() ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'EIN') {
                system.debug(parser.getText() );
                oShakeCharity.EIN__c=parser.getText() ;
                if(sAccountId == null){
                	newAcc.EIN__c=parser.getText();    
                }
                parser.nextValue();

            }
            
            if (parser.getCurrentName() == 'STREET') {
                system.debug(parser.getText() );
                oShakeCharity.Billing_Street__c=parser.getText() ;
                parser.nextValue();

            }
            
            if (parser.getCurrentName() == 'CLASSIFICATION') {
                system.debug(parser.getText() );
                oShakeCharity.Classification__c=parser.getText() ;
                parser.nextValue();

            } 
            
            if (parser.getCurrentName() == 'ORGANIZATION') {
                system.debug(parser.getText() );
                oShakeCharity.Organaization_Id__c=parser.getText() ;
                parser.nextValue();

            } 
            
            if (parser.getCurrentName() == 'REVENUE_AMT') {
                system.debug(parser.getText() );
                oShakeCharity.Total_Revenue__c=parser.getText() ;
                parser.nextValue();
            } 
            
            if (parser.getCurrentName() == 'SUBSECTION') {
                system.debug(parser.getText() );
                oShakeCharity.Subsection_Code__c=parser.getText() ;
                if(parser.getText() == '1'){
                    oShakeCharity.Foundation_Status__c='501(c)(1) ' + + ' Corporations Organized under Act of Congress (including Federal Credit Unions)';
                }
                if(parser.getText() == '2'){
                    oShakeCharity.Foundation_Status__c='501(c)(2) ' + + ' Title Holding Corporation for Exempt Organization';
                }
                if(parser.getText() == '3'){
                    oShakeCharity.Foundation_Status__c='501(c)(3) ' + + ' Religious, Educational, Charitable, Scientific, Literary, Testing for Public Safety, to Foster National or International Amateur Sports Competition, or Prevention of Cruelty to Children or Animals Organizations';
                }
                if(parser.getText() == '4'){
                    oShakeCharity.Foundation_Status__c='501(c)(4) ' + + ' Civic Leagues, Social Welfare Organizations, and Local Associations of Employees';
                }     
                if(parser.getText() == '5'){
                    oShakeCharity.Foundation_Status__c='501(c)(5) ' + + ' Labor, Agricultural, and Horticultural Organizations';
                }
                parser.nextValue();
            }
             
            if (parser.getCurrentName() == 'ICO') {
                system.debug(parser.getText() );
                string sContactPerson = parser.getText();
                oShakeCharity.In_Care_of__c=sContactPerson.replace('%','') ;
                parser.nextValue();
            }
             
            if (parser.getCurrentName() == 'INCOME_AMT') {
                system.debug(parser.getText() );
                oShakeCharity.Income_AMT__c=parser.getText() ;
                parser.nextValue();
            }
             
            if (parser.getCurrentName() == 'ASSET_CD') {
                system.debug(parser.getText() );
                //oShakeCharity.Income_AMT__c=parser.getText() ;
                parser.nextValue();
            }
             
            if (parser.getCurrentName() == 'TAX_PERIOD') {
                system.debug(parser.getText() );
                string sTaxYear = parser.getText();
                string sYear = ((String)sTaxYear).left(4);
                string sMonth = ((String)sTaxYear).right(2);
                oShakeCharity.Tax_Year__c=sMonth+'/'+sYear ;
                parser.nextValue();
            }
             
            if (parser.getCurrentName() == 'RULING') {
                system.debug(parser.getText() );
                string sRuleYear = parser.getText();
                string sYear = ((String)sRuleYear).left(4);
                string sMonth = ((String)sRuleYear).right(2);
                oShakeCharity.Ruling_Date__c=sMonth+'/'+sYear ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'ZIP') {
                system.debug(parser.getText() );
                oShakeCharity.Billing_Pincode__c=parser.getText() ;
                parser.nextValue();
            }
            
            if (parser.getCurrentName() == 'DEDUCTIBILITY') {
                system.debug(parser.getText() );
                oShakeCharity.Deductablity_Status_Desacription__c=parser.getText() ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'ACTIVITY') {
                system.debug(parser.getText() );
                oShakeCharity.Activity__c=parser.getText() ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'FILING_REQ_CD') {
                system.debug(parser.getText() );
                oShakeCharity.Filing_REQ_CD__c=parser.getText() ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'OrgNAME') {
                system.debug(parser.getText() );
                oShakeCharity.IRS_Org_Name__c=parser.getText() ;
                if(sAccountId == null){
                	newAcc.Name=parser.getText();    
                }
                parser.nextValue(); 
            }

            if (parser.getCurrentName() == 'FOUNDATION') {
                system.debug(parser.getText() );
                //oShakeCharity.Foundation_Code__c=parser.getText() ;
                oShakeCharity.Foundation__c=parser.getText() ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'NTEE_CD') {
                system.debug(parser.getText() );
                oShakeCharity.NTEE_Code__c=parser.getText() ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'STATUS') {
                system.debug(parser.getText() );
                oShakeCharity.Status__c=parser.getText() ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'PF_FILING_REQ_CD') {
                system.debug(parser.getText() );
                oShakeCharity.PF_Filing_REQ_CD__c=parser.getText() ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'ACCT_PD') {
                system.debug(parser.getText() );
                oShakeCharity.ACCT_PD__c=parser.getText() ;
                parser.nextValue();
            }

            if (parser.getCurrentName() == 'STATE') {
                system.debug(parser.getText() );
                oShakeCharity.Billing_State__c=parser.getText() ;
                parser.nextValue();
            }
            
            if (parser.getCurrentName() == 'GROUP') {
                system.debug(parser.getText() );
                oShakeCharity.Group__c=parser.getText() ;
                parser.nextValue();
            }
			if(sAccountId == null){
                insert newAcc;
                sAccountId = newAcc.Id;
        	}
            oShakeCharity.Account__c=sAccountId;
            createShakeCharity.add(oShakeCharity);
        }
        if(createShakeCharity.size()>0){
            insert createShakeCharity;   
        }
        return createShakeCharity;
    }
}