trigger SCXVITrigger on Opportunity (after insert,after update, after delete,after undelete) {
    
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUndelete)){
        
        SCXVIHandler.HighestOpp(Trigger.new,null);
    }
    else if(Trigger.isAfter && Trigger.isUpdate){
        SCXVIHandler.HighestOpp(Trigger.new,Trigger.oldmap); 
    }
    else if(Trigger.isAfter && Trigger.isDelete){
        SCXVIHandler.HighestOpp(Trigger.old,null);
    }
}