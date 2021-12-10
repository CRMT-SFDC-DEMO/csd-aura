({
	doInit : function(component, event, helper){
		let fields = component.get('v.fields');
        let columnsParse = JSON.parse(fields);
        let columns = Object.values(columnsParse);
        component.set('v.columns', columns);
		helper.getUrl(component,event);
	},

	handleRowAction: function (component, event, helper){
		var action = event.getParam('action');
        var row = event.getParam('row');
        component.set("v.currentRecordId", row.recordId);
        switch (action.name){
			case 'delete':
				component.set("v.isModalOpen", true);
				component.set("v.recordName", row.Name);
                break;
        }
    },
	
	closeModal: function(component, event, helper){
		component.set("v.isModalOpen", false);
	},
	
	handleDelete : function(component, event, helper){
		helper.deleteRecord(component,event);
	},

	handleApplicationEvent : function(component, event, helper){
		let message = event.getParam("refresh");
		if(message){
			helper.getUrl(component,event);
		}
	}
})