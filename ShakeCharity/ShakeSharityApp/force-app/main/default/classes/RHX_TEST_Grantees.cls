@isTest(SeeAllData=true)
public class RHX_TEST_Grantees {
	static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM Grantees__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Grantees__c()
            );
        }
    	rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}