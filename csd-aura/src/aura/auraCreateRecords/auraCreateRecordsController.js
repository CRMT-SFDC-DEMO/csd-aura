({
    doInit : function(component, event, helper){
        let fields = component.get('v.fields');
        fields = JSON.parse(fields);
        let fieldListArr = Object.values(fields);
        component.set('v.fieldListArr', fieldListArr);
        helper.getRecordTypeIdfromController(component,event); 
    },

    handleSuccess : function(component, event, helper){
        let recordType = component.get('v.recordTypeName');
        component.find('notifLib').showToast({
            "title": recordType + " creato!",
            "message": recordType + " inserito correttamente",
            "variant": "success",
        });
        var appEvent = $A.get("e.c:updateDataTable");
        appEvent.setParams({ "refresh" : true });
        appEvent.fire();
        helper.handleReset(component,event)
    }
})