public class TaskTriggerHandler implements ITriggerHandler
{
    // Allows unit tests (or other code) to disable this trigger for the transaction
    public static Boolean TriggerDisabled = false;
    // Checks to see if the trigger has been disabled either by custom setting or by running code
    public Boolean isDisabled()
    {
        return TriggerDisabled;
    }
    
    public void beforeInsert(List<SObject> newItems) {
        //System.debug('TaskTriggerHandler.beforeInsert running');
    }
 
    public void beforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        //System.debug('TaskTriggerHandler.beforeUpdate running');
    }
 
    public void beforeDelete(Map<Id, SObject> oldItems) {
        //System.debug('TaskTriggerHandler.beforeDelete running');
    }
 
    public void afterInsert(Map<Id, SObject> newItems) {
        System.debug('TaskTriggerHandler.afterInsert running');
        //Trigger to update the activity count fields on the Lead level when completed tasks are inserted
        List<Task> TaskList = new List<Task>();
        Id LeadId;
        Integer Calls=0;
        Integer Emails=0;
        Integer Appointments=0;
        for(Task t:((Map<Id, Task>)newItems).values()){
            LeadId = t.WhoId;
            System.debug('LeadId= ' + LeadId);
    	}
        TaskList = [SELECT Id, Status, Type FROM Task WHERE WhoId=:LeadId];
        System.debug('LeadTaskSize=' + TaskList.size());
        
        for(Task t:TaskList){
            if(t.Status=='Completed' && t.Type=='Call'){
                Calls=Calls+1;
            } 
            if(t.Status=='Completed' && (t.Type=='Email' || t.Type=='Sent' || t.Type=='LinkedIn Message')){
                Emails=Emails+1;
            }
            if(t.Status=='Completed' && (t.Type=='In Person Meeting' || t.Type=='Appointment')){
                Appointments=Appointments+1;
            }                
        }
        List<Lead> Lead = new List<Lead>(); 
        List<Lead> LeadList = [SELECT Id FROM Lead WHERE Id=:LeadId];
        System.debug('LeadSize=' + LeadList.size());
        for(Lead l: LeadList){
            l.Activity_Count_Call__c = Calls;
            l.Activity_Count_Email__c = Emails;
            l.Activity_Count_Appointment__c = Appointments;
            Lead.add(l);  
        }
        if(Lead.size()>0){
            update Lead;
        }        
        System.debug('Number of Tasks: ' + 'Calls=' + Calls +' Emails=' + Emails + ' Appointments=' + Appointments);     
    }
 
    public void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        System.debug('TaskTriggerHandler.afterUpdate running');
        //Trigger to update the activity count fields on the Lead level when tasks are updated to completed
        List<Task> TaskList = new List<Task>();
        Id LeadId;
        Integer Calls=0;
        Integer Emails=0;
        Integer Appointments=0;
        for(Task t:((Map<Id, Task>)newItems).values()){
            LeadId = t.WhoId;
            System.debug('LeadId= ' + LeadId);
    	}
        TaskList = [SELECT Id, Status, Type FROM Task WHERE WhoId=:LeadId];
        System.debug('LeadTaskSize=' + TaskList.size());
        
        for(Task t:TaskList){
            if(t.Status=='Completed' && t.Type=='Call'){
                Calls=Calls+1;
            } 
            if(t.Status=='Completed' && (t.Type=='Email' || t.Type=='Sent' || t.Type=='LinkedIn Message')){
                Emails=Emails+1;
            }
            if(t.Status=='Completed' && (t.Type=='In Person Meeting' || t.Type=='Appointment')){
                Appointments=Appointments+1;
            }                
        }
        List<Lead> Lead = new List<Lead>(); 
        List<Lead> LeadList = [SELECT Id FROM Lead WHERE Id=:LeadId];
        System.debug('LeadSize=' + LeadList.size());
        for(Lead l: LeadList){
            l.Activity_Count_Call__c = Calls;
            l.Activity_Count_Email__c = Emails;
            l.Activity_Count_Appointment__c = Appointments;
            Lead.add(l);  
        }
        if(Lead.size()>0){
            update Lead;
        }        
        System.debug('Number of Tasks: ' + 'Calls=' + Calls +' Emails=' + Emails + ' Appointments=' + Appointments);
    }
 
    public void afterDelete(Map<Id, SObject> oldItems) {
        //System.debug('TaskTriggerHandler.afterDelete running');
    }
 
    public void afterUndelete(Map<Id, SObject> oldItems) {
        //System.debug('TaskTriggerHandler.afterUndelete running');
    }
}