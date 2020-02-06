public class TriggerDispatcher 
{
    /*
    Call this method from your trigger, passing in an instance of a trigger handler which implements TriggerHandler.
    This method will fire the appropriate methods on the handler depending on the trigger context.
    */
    public static void run(ITriggerHandler handler)
    {
        // Check to see if the trigger has been disabled. If it has, return
        if (handler.IsDisabled())
            return;
             
        // Detect the current trigger context and fire the relevant methods on the trigger handler:
 
        // Before trigger logic
        if (Trigger.isBefore) {
            if (Trigger.isInsert)
                handler.beforeInsert(Trigger.new);
 
            if (Trigger.isUpdate)
                handler.beforeUpdate(Trigger.newMap, Trigger.oldMap);
 
            if (Trigger.isDelete)
                handler.beforeDelete(Trigger.oldMap);
        }
         
        // After trigger logic
        if (Trigger.isAfter) {
            if (Trigger.isInsert)
                handler.afterInsert(Trigger.newMap);
 
            if (Trigger.isUpdate)
                handler.afterUpdate(Trigger.newMap, Trigger.oldMap);
 
            if (Trigger.isDelete)
                handler.afterDelete(Trigger.oldMap);
 
            if (Trigger.isUndelete)
                handler.afterUndelete(Trigger.oldMap);
        }
    }
}