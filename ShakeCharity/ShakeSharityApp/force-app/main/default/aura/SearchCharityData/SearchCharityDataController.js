({
	searchData : function(component, event, helper) {
		//call apex class method
      var action = component.get('c.callAwsgateway');
      var vEIN = component.find("sEIN").get("v.value");
      action.setParams({
            "EIN": vEIN
       });  
      console.log(vEIN);
      action.setCallback(this, function(response) {
        //store state of response
        var state = response.getState();
        if (state === "SUCCESS") {
          //set response value in wrapperList attribute on component.
			console.log('testing='+response.getReturnValue()[0].sEIN);

          if(response.getReturnValue()[0].sEIN != undefined){
                component.set('v.ReponseList', response.getReturnValue());
                  console.log('Consollllllllllllll'+JSON.stringify(response.getReturnValue()) );
                  //component.set('v.sRecordId', v.wrapperList.sRecordID);
                  component.set("v.sRecordId", response.getReturnValue().sRecordID)
                  //var vRecordId = component.find("sRecordId").get("v.value");
             	  
            }
           else {
             	alert('No record against this EIN number.'); 	      
          } 
        } 

      });
      $A.enqueueAction(action);
	},
    
    searchDataOrg : function(component, event, helper) {
      var vEIN = component.find("sOrg").get("v.value");
      helper.searchDataOrgHelper(component, event, helper,vEIN);//get data from the helper
      component.set("v.Spinner", true);  
	},
    
    openViewRecord : function(component,event,helper){
     // make Spinner attribute to false for hide loading spinner
     	//var vEIN = component.find("sRecordId").get("v.value");  
       var vRecordId = event.getSource().get('v.value');  
       var vHost = window.location.hostname;
      // alert(vHost); 
       var vUrl =  vHost+'/'+vRecordId;
       window.open('https://latinocf--demo.my.salesforce.com/'+vRecordId,'_blank');
    },
    
	createRecordData : function(component,event,helper){
     var action = component.get('c.createRecord');
     var vEIN = component.find("sEIN").get("v.value");
     console.log('vEIN=='+vEIN);   
      action.setParams({
           "EIN": vEIN
      });  
      action.setCallback(this, function(response) {
        //store state of response
        var state = response.getState();
        if (state === "SUCCESS") {
            console.log('Consollllllllllllll'+JSON.stringify(response.getReturnValue()) ); 
            alert('Record has been created successfully');
        }
      });
      $A.enqueueAction(action);  
    }, 
    
    createRecordDataOrg : function(component,event,helper){
     	var vEIN = event.getSource().get('v.value'); 
        var vEINOrg = component.find("sOrg").get("v.value");
     	helper.createRecordDataOrghelper(component, event, helper,vEIN);//get data from the helper   
        helper.searchDataOrgHelper(component, event, helper,vEINOrg);//get data from the helper
       component.set("v.Spinner", true);
    }, 
    
    // this function automatic call by aura:waiting event  
    showSpinner: function(component, event, helper) {
       // make Spinner attribute true for display loading spinner 
        component.set("v.Spinner", true); 
   },
    
 	// this function automatic call by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
     // make Spinner attribute to false for hide loading spinner    
       component.set("v.Spinner", false);
    },
})