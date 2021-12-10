({
	getObjectAndFields: function(component,event){
		let url =  component.get("v.url");
		let action = component.get("c.getObjectAndFields");
		let object = component.get("v.obj");
		let fieldsFromDesign = component.get("v.query");
		let recordTypeName = component.get("v.recordTypeName");
		action.setParams({obj: object, fields: fieldsFromDesign, recordType: recordTypeName});
		action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
				let result =JSON.parse(JSON.stringify(response.getReturnValue()));
				result.forEach(element =>{
					element.nomeDipendente = element.Dipendente__r.Name;
					element.recordId = element.Id;
					element.Id = url + element.Id;
				});
                component.set('v.data', result);
            }
            else if (state === "INCOMPLETE"){
                console.log('INCOMPLETE');
            }
            else if (state === "ERROR"){
                var errors = response.getError();
                if (errors){
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

	getUrl : function(component,event){
		let action = component.get('c.getURL');
		action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
				component.set("v.url", response.getReturnValue());
				let helper = this;
				helper.getObjectAndFields(component,event);
            }
            else if (state === "INCOMPLETE"){
				console.log('INCOMPLETE');
                
            }
            else if (state === "ERROR"){
                var errors = response.getError();
                if (errors){
                    if (errors[0] && errors[0].message){
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else{
                    console.log("Unknown error");
                }
            }
        });
		$A.enqueueAction(action);
	},

	deleteRecord: function(component,event){
		let currentRecord = [];
		let recordId = component.get("v.currentRecordId");
		currentRecord.push(recordId);
		let action = component.get("c.deleteRecord");
		action.setParams({recordIds: currentRecord});
		action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
                component.find('notifLib').showToast({
                    "title": "Record Eliminato!",
                    "message": " Record eliminato correttamente",
                    "variant": "success",
                });
				component.set("v.isModalOpen", false);
                let helper = this;
                helper.getObjectAndFields(component,event);
            }
            else if (state === "INCOMPLETE"){
                console.log("INCOMPLETE");
            }
            else if (state === "ERROR"){
                var errors = response.getError();
                if (errors){
                    if (errors[0] && errors[0].message){
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else{
                    console.log("Unknown error");
                }
            }
        });
	    $A.enqueueAction(action);
	}
})