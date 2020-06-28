global class AWSCallout {
     webservice static string callAwsgateway(string EIN) {
        Http http = new Http();
 		string sShakeEIN;
        string sReturn = 'wrongEIN';
        List<ShakeCharity__c> UpdateShakeCharity = new List<ShakeCharity__c>();
		List<ShakeCharity__c> createShakeCharity = new List<ShakeCharity__c>();
		ShakeCharity__c  newShake = new ShakeCharity__c();
        system.debug('EIN====='+EIN );
        string sEIN = EIN.replace('-', ''); 
        string sEndPoint = 'https://agbg6e5ci7.execute-api.us-east-2.amazonaws.com/CharityBeta/charitydata/'+sEIN;
        HttpRequest request = new HttpRequest();

        //Please set the endpoint of API gateway which we are going to create in later section
        request.setEndpoint(sEndPoint);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');

        // Set the body as a JSON object
        HttpResponse response = http.send(request);
        System.debug('response==='+response.getBody());
        String body;
        string sAccountId;
        JSONParser parser = JSON.createParser(response.getBody());
        system.debug(parser );
        system.debug(parser.nextToken());
        system.debug(parser.getCurrentToken());
		List<Account> oAccount = [SELECT Id FROM Account WHERE EIN__c =:EIN LIMIT 1];
        if(oAccount.size() >0){
        	sAccountId = oAccount[0].Id;     
        }
        List<ShakeCharity__c> lstCharity = [SELECT Id, Name, Bridge_Number__c, Billing_Street__c, Billing_City__c, Billing_State__c, Billing_Pincode__c, Billing_Country__c, Total_Assets__c, Company_Mission__c, Total_Expense__c, Total_Revenue__c, Contact_Email__c, In_Care_of__c, Contact_Phone__c, Contact_Title__c, EIN__c, Form_Type__c, Foundation_Code__c, Independent__c, NTEE_Code__c, County__c,  Organaization_Id__c  FROM ShakeCharity__c WHERE EIN__c=:EIN LIMIT 1];
         if(lstCharity != null && lstCharity.size()>0){
             for(ShakeCharity__c oShakeCharity : lstCharity){
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
                        parser.nextValue();
                    } 
                    if (parser.getCurrentName() == 'CITY') {
                        system.debug(parser.getText() );
                        oShakeCharity.Billing_City__c=parser.getText() ;
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
                        parser.nextValue();

                    }if (parser.getCurrentName() == 'STREET') {
                        system.debug(parser.getText() );
                        oShakeCharity.Billing_Street__c=parser.getText() ;
                        parser.nextValue();

                    }if (parser.getCurrentName() == 'CLASSIFICATION') {
                        system.debug(parser.getText() );
                        parser.nextValue();

                    } if (parser.getCurrentName() == 'ORGANIZATION') {
                        system.debug(parser.getText() );
                        oShakeCharity.Organaization_Id__c=parser.getText() ;
                        parser.nextValue();

                    } if (parser.getCurrentName() == 'REVENUE_AMT') {
                        system.debug(parser.getText() );
                        oShakeCharity.Total_Revenue__c=parser.getText() ;
                        parser.nextValue();

                    } if (parser.getCurrentName() == 'SUBSECTION') {
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
                        parser.nextValue();
                    }

                    if (parser.getCurrentName() == 'ASSET_CD') {
                        system.debug(parser.getText() );
                        oShakeCharity.Total_Assets__c=parser.getText() ;
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
                        parser.nextValue();
                    }

                    if (parser.getCurrentName() == 'FILING_REQ_CD') {
                        system.debug(parser.getText() );
                        parser.nextValue();
                    }

                    if (parser.getCurrentName() == 'FOUNDATION') {
                        system.debug(parser.getText() );
                        oShakeCharity.Foundation_Code__c=parser.getText() ;
                        parser.nextValue();
                    }

                    if (parser.getCurrentName() == 'NTEE_CD') {
                        system.debug(parser.getText() );
                        oShakeCharity.NTEE_Code__c=parser.getText() ;
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
                        oShakeCharity.Billing_State__c=parser.getText() ;
                        parser.nextValue();
                    }

                    if (parser.getCurrentName() == 'NAME') {
                        system.debug(parser.getText() );
                        oShakeCharity.IRS_Org_Name__c=parser.getText() ;
                        parser.nextValue();
                    }
                    oShakeCharity.Account__c=sAccountId;
                    UpdateShakeCharity.add(oShakeCharity);
                }   
            } 

        }
		else {
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
                    newShake.Income_CD__c=parser.getText() ;
					parser.nextValue();
				} 
				if (parser.getCurrentName() == 'CITY') {
					system.debug(parser.getText() );
					newShake.Billing_City__c=parser.getText() ;
					parser.nextValue();
				}
				if (parser.getCurrentName() == 'ASSET_AMT') {
					system.debug(parser.getText() );
                    newShake.Asset_AMT__c=parser.getText() ;
					parser.nextValue();
				}
				if (parser.getCurrentName() == 'AFFILIATION') {
					newShake.Affiliation__c=parser.getText() ;
					system.debug(parser.getText() );
					parser.nextValue();
				}
                if (parser.getCurrentName() == 'AUTOMATIC_REVOCATION') {
                    system.debug(parser.getText() );
                    string sAutomaticRev = parser.getText();
                    newShake.Automatic_Revocation__c=sAutomaticRev.replace('\r','') ;
                    parser.nextValue();
                }
				if (parser.getCurrentName() == 'EIN') {
					system.debug(parser.getText() );
                    newShake.EIN__c=parser.getText() ;
                    sShakeEIN=parser.getText() ;
					parser.nextValue();

				}if (parser.getCurrentName() == 'STREET') {
					system.debug(parser.getText() );
					newShake.Billing_Street__c=parser.getText() ;
					parser.nextValue();

				}if (parser.getCurrentName() == 'CLASSIFICATION') {
					system.debug(parser.getText() );
                    newShake.Classification__c=parser.getText() ;
					parser.nextValue();

				} if (parser.getCurrentName() == 'ORGANIZATION') {
					system.debug(parser.getText() );
					newShake.Organaization_Id__c=parser.getText() ;
					parser.nextValue();

				} if (parser.getCurrentName() == 'REVENUE_AMT') {
					system.debug(parser.getText() );
					newShake.Total_Revenue__c=parser.getText() ;
					parser.nextValue();

				} if (parser.getCurrentName() == 'SUBSECTION') {
					system.debug(parser.getText() );
					newShake.Subsection_Code__c=parser.getText() ;
					if(parser.getText() == '1'){
						newShake.Foundation_Status__c='501(c)(1) ' + + ' Corporations Organized under Act of Congress (including Federal Credit Unions)';
					}
					if(parser.getText() == '2'){
						newShake.Foundation_Status__c='501(c)(2) ' + + ' Title Holding Corporation for Exempt Organization';
					}
					if(parser.getText() == '3'){
						newShake.Foundation_Status__c='501(c)(3) ' + + ' Religious, Educational, Charitable, Scientific, Literary, Testing for Public Safety, to Foster National or International Amateur Sports Competition, or Prevention of Cruelty to Children or Animals Organizations';
					}
					if(parser.getText() == '4'){
						newShake.Foundation_Status__c='501(c)(4) ' + + ' Civic Leagues, Social Welfare Organizations, and Local Associations of Employees';
					}     
					if(parser.getText() == '5'){
						newShake.Foundation_Status__c='501(c)(5) ' + + ' Labor, Agricultural, and Horticultural Organizations';
					}
					parser.nextValue();
				}

				if (parser.getCurrentName() == 'ICO') {
					system.debug(parser.getText() );
					string sContactPerson = parser.getText();
					newShake.In_Care_of__c=sContactPerson.replace('%','') ;
					parser.nextValue();
				}

				if (parser.getCurrentName() == 'INCOME_AMT') {
					system.debug(parser.getText() );
                    newShake.Income_AMT__c=parser.getText() ;
					parser.nextValue();
				}

				if (parser.getCurrentName() == 'ASSET_CD') {
					system.debug(parser.getText() );
					newShake.Total_Assets__c=parser.getText() ;
                    
					parser.nextValue();
				}

				if (parser.getCurrentName() == 'TAX_PERIOD') {
                    system.debug(parser.getText() );
                    string sTaxYear = parser.getText();
                    if(sTaxYear != null){
                        if(sTaxYear.isNumeric()){
                            string sYear = ((String)sTaxYear).left(4);
                            string sMonth = ((String)sTaxYear).right(2);
                            newShake.Tax_Year__c=sMonth+'/'+sYear ;
                        } 
                        else {
                            newShake.Tax_Year__c=parser.getText();   
                        }
                    }
                    parser.nextValue(); 
                }

				if (parser.getCurrentName() == 'RULING') {
                    system.debug(parser.getText() );
                    string sRuleYear = parser.getText();
                    if(sRuleYear != null){
                        if(sRuleYear.isNumeric()){
                            string sYear = ((String)sRuleYear).left(4);
                            string sMonth = ((String)sRuleYear).right(2);
                            newShake.Ruling_Date__c=sMonth+'/'+sYear ;
                        }
                        else {
                            newShake.Ruling_Date__c=parser.getText();    
                        }
                    }
                    parser.nextValue(); 
                }

				 if (parser.getCurrentName() == 'ZIP') {
					system.debug(parser.getText() );
					newShake.Billing_Pincode__c=parser.getText() ;
					parser.nextValue();
				}

				if (parser.getCurrentName() == 'DEDUCTIBILITY') {
					system.debug(parser.getText() );
					newShake.Deductablity_Status_Desacription__c=parser.getText() ;
					parser.nextValue();
				}

				if (parser.getCurrentName() == 'ACTIVITY') {
					system.debug(parser.getText() );
                    newShake.Activity__c=parser.getText() ;
					parser.nextValue();
				}

				if (parser.getCurrentName() == 'FILING_REQ_CD') {
					system.debug(parser.getText() );
                    newShake.Filing_REQ_CD__c=parser.getText() ;
					parser.nextValue();
				}
                
                if (parser.getCurrentName() == 'OrgNAME') {
					system.debug(parser.getText() );
					newShake.IRS_Org_Name__c=parser.getText() ;
                    newShake.Org_Name__c=parser.getText() ;
					parser.nextValue();
				}
                
                if (parser.getCurrentName() == 'REVOCATION_DATE') {
                    system.debug(parser.getText() );
                    newShake.Revocation_Date__c=parser.getText() ;
                    //oShakeCharity.Foundation__c=parser.getText() ;
                    parser.nextValue();
                }

				if (parser.getCurrentName() == 'FOUNDATION') {
					system.debug(parser.getText() );
					newShake.Foundation__c=parser.getText() ;
					parser.nextValue();
				}
                
				if (parser.getCurrentName() == 'NTEE_CD') {
					system.debug(parser.getText() );
					newShake.NTEE_Code__c=parser.getText() ;
					parser.nextValue();
				}

				if (parser.getCurrentName() == 'STATUS') {
					system.debug(parser.getText() );
                    newShake.Status__c=parser.getText() ;
					parser.nextValue();
				}

				if (parser.getCurrentName() == 'PF_FILING_REQ_CD') {
					system.debug(parser.getText() );
                    newShake.PF_Filing_REQ_CD__c=parser.getText() ;
					parser.nextValue();
				}

				if (parser.getCurrentName() == 'ACCT_PD') {
					system.debug(parser.getText() );
                    newShake.ACCT_PD__c=parser.getText() ;
					parser.nextValue();
				}

				if (parser.getCurrentName() == 'STATE') {
					system.debug(parser.getText() );
					newShake.Billing_State__c=parser.getText() ;
					parser.nextValue();
				}
                if (parser.getCurrentName() == 'GROUP') {
                    system.debug(parser.getText() );
                    newShake.Group__c=parser.getText() ;
                    parser.nextValue();
                }
				newShake.Account__c=sAccountId;
				createShakeCharity.add(newShake);
			} 
		} 
        if(UpdateShakeCharity.size()>0){
            Update UpdateShakeCharity;   
        }
        if(sShakeEIN != null){
         	if(createShakeCharity.size()>0){
                insert createShakeCharity;
                sReturn = 'success';
                return sReturn;
            }  
        }
		else{
			sReturn = 'wrongEIN';
			return sReturn;
        } 
        return sReturn; 
    }
	
}