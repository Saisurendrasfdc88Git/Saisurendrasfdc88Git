/*SAISURENDR SESHAPU*/
trigger SCXVIITrigger on Contact (before insert,before update) {
    
    if(Trigger.isBefore && Trigger.isInsert){
        SCXVIIHandler.enforceContacts(trigger.new,null);
    }
    else if(Trigger.isBefore && Trigger.isUpdate){
        SCXVIIHandler.enforceContacts(trigger.new,trigger.oldmap);
    }

}