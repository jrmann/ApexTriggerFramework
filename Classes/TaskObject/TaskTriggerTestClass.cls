@isTest
private class TaskTriggerTestClass {
    @isTest static void insertNewCompletedTask() {
        // Add completed tasks of different types to a lead and see if it updates the activity count fields
        Task testTask = new Task(Type='Call',Status='Completed',Subject='Test');
        Task testTask2 = new Task(Type='Email',Status='Completed',Subject='Test2');
        Task testTask3 = new Task(Type='LinkedIn Message',Status='Completed',Subject='Test3');
        insert testTask;
        insert testTask2;
        insert testTask3;
        
        Test.startTest();
            testTask.Type='Appointment';
            update testTask;
        Test.stopTest();
       
    }
    
}