({
	getRecordTypeIdfromController : function(component,event){
		let action = component.get("c.getRecordTypeId");
		action.setParams({recordType : component.get('v.recordTypeName')});
		action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.recordTypeId', response.getReturnValue());
            }
            else if (state === "INCOMPLETE"){
                console.log("INCOMPLETE");
            }
            else if (state === "ERROR"){
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message){
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
		$A.enqueueAction(action);
	},

    handleReset : function(component, event){
        component.find('field').forEach(function(f){
            f.reset();
        });
    }
})