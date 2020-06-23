/*quickAddController.js*/
({
    pageload: function(component, event, helper) {
        helper.getAccountdata(component)
    },    
    clickAdd: function(component, event, helper) {
		var vAccount = component.get("v.singleAccount");
        var vEIN = vAccount[0].EIN__c;
        console.log('vEIN'+vEIN);
        helper.getcharitydata(component,vEIN)
		
        // Display the total in a "toast" status message
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "title": "Successfull: " ,
            "message": "Data Retrieved."
        });
        resultsToast.fire();

        // Close the action panel
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
        location.reload();
    }

})