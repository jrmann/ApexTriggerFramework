trigger TaskTrigger on Task (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    System.debug('TaskTrigger running');
    TriggerDispatcher.run(new TaskTriggerHandler());
}