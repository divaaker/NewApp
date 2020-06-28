({
	searchDataOrgHelper : function(component, event, helper,vEIN ) {
		//call apex class method
      var action = component.get('c.callAwsgatewayOrgSearch');
      action.setParams({
            "EIN": vEIN
       });  
      console.log(vEIN);
      action.setCallback(this, function(response) {
        //store state of response
          var state = response.getState();
          if (state === "SUCCESS") {
             // if(response.getReturnValue().sEIN != undefined){
                //set response value in wrapperList attribute on component.
              if(response.getReturnValue().length > 0){
                  component.set('v.wrapperListOrg', response.getReturnValue());
                  console.log('Consollllllllllllll'+JSON.stringify(response.getReturnValue()) );
                  component.set("v.sRecordId", response.getReturnValue().sRecordID) 	   
              }
              else{
               		alert("We are unable to retrieve this Organization’s information in our database. Please make sure that this is a Charitable Organization.");
          	 }
          }
          else {
              alert("We are unable to retrieve this Organization’s information in our database. Please make sure that this is a Charitable Organization.");
          }
      });
      $A.enqueueAction(action);
	},
    
    createRecordDataOrghelper : function(component,event,helper,vEIN){
     component.set("v.Spinner", true);   
     var action = component.get('c.createRecord');
     var vEIN = event.getSource().get('v.value');
     console.log('vEIN=='+vEIN);   
      action.setParams({
           "EIN": vEIN
      });  
      action.setCallback(this, function(response) {
        //store state of response
        var state = response.getState();
        if (state === "SUCCESS") {
            component.set("v.Spinner", true);
            var vResponse = JSON.stringify(response.getReturnValue());
            console.log('Consollllllllllllll21'+JSON.stringify(response.getReturnValue()) ); 
            console.log(vResponse);
            if(vResponse != 'null'){
            	alert('Record has been created successfully');    
                component.set("v.Spinner", false); 
            }
            else{
            	alert('EIN/Tax ID can not be found. Please make sure that the EIN/Tax ID is correct.'); 
                component.set("v.Spinner", false); 
            }
        }
      });
      $A.enqueueAction(action);   
    },
})