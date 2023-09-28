trigger SCXVTrigger on Contact (after insert,after update,after delete,after undelete) {
    
    if(Trigger.isAfter && Trigger.isUpdate){    
        SCXV.getSalary(trigger.new,trigger.oldmap);
    }
    else if(Trigger.isAfter && Trigger.isDelete){
        SCXV.getSalary(trigger.old,null);
    }
    else if(Trigger.isAfter &&(Trigger.isInsert || Trigger.isUndelete)){
        SCXV.getSalary(trigger.new,null);
    }

}