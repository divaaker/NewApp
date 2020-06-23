public class GetCharityCtrl {
	@auraEnabled
    Public  static string getAccount(Id sAccountId){
        string sSuccess = 'Success';
        List<ShakeCharity__c> lstShakeCharity = [SELECT Id, Account__c FROM ShakeCharity__c WHERE Account__c=:sAccountId];
        if(lstShakeCharity != null && lstShakeCharity.size()>0){
        	sSuccess = 'RecordExist' ;  
        }
        else {
        	List<Account> lstAccount = [SELECT Id, Name, EIN__c FROM Account WHERE Id = :sAccountId];
            if(lstAccount.size()>0){
                for(Account oAcc : lstAccount){
                    if(oAcc.EIN__c != null){
                        AWSCallout.callAwsgateway(oAcc.EIN__c);  
                        sSuccess = 'Success';
                    }
                    else {
                         sSuccess = 'Failure';
                    } 
                } 
            }    
        }
    	return sSuccess;    
    }
    
    @auraEnabled
    Public  static string getCharityData(string sEIN){
        string sSuccess = 'Success';
        AWSCallout.callAwsgateway(sEIN);
    	return sSuccess;
    }
}