({
	getAccountdata : function(component) {
        var vAccounId = component.get("v.recordId");
        console.log('vAccounId==='+vAccounId);
		var action = component.get("c.getAccount"); //Calling Apex class controller 'getQuesDetail' method
        action.setParams({
            sAccountId: vAccounId
        });
        action.setCallback(this, function(response) {
            var state = response.getState(); //Checking response status
            if (component.isValid() && state === "SUCCESS") 
            {
                var result=response.getReturnValue();
                var vMessage = JSON.stringify(response.getReturnValue());
                console.log('fetchExhibitors1'+result);
                console.log('fetchExhibitors'+JSON.stringify(response.getReturnValue()));
                if(result == "Success"){
                	component.set("v.sStatus",'Success');
                    location.reload();
                }
                else if(result == "RecordExist"){
                	component.set("v.sStatus",'RecordExist'); 
                }
                else{
                    component.set("v.sStatus",'Failure'); 
                }
                component.set("v.singleAccount",result);// Adding values in Aura attribute variable.
            }
        });
        $A.enqueueAction(action);
	},
    
    getcharitydata : function(component,vEIN) {
        console.log('vEIN==='+vEIN);
		var action = component.get("c.getCharityData"); //Calling Apex class controller 'getQuesDetail' method
        action.setParams({
            sEIN: vEIN
        });
        action.setCallback(this, function(response) {
            var state = response.getState(); //Checking response status
            if (component.isValid() && state === "SUCCESS") 
            {
                var result=response.getReturnValue();
                console.log('fetchExhibitors'+JSON.stringify(response.getReturnValue()));
                //component.set("v.singleAccount",result);// Adding values in Aura attribute variable.
            }
        });
        $A.enqueueAction(action);
	}
})