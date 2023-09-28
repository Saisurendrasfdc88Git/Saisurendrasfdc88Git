/*SAISURENDR SESHAPU*/
public class SCXVIIHandler {
    
    public static void enforceContacts(list<contact> newCons,map<id,contact>oldMap){
       
        set<id> accids = new set<id>();
        if(!newCons.isEmpty()){
            for(contact con : newCons){
                
                if(oldMap != null){
                    
                    contact oldCon = oldMap.get(con.Id);
                    if(oldCon != null){
                    if(oldCon.accountId != con.AccountId){
                        accids.add(oldCon.accountId);
                        accids.add(con.AccountId);
                    }
                    else{
                        accids.add(con.AccountId);
                    }
                    }
                }
                else{
                    accids.add(con.AccountId);
                }    
            } 
            
            list<contact> conlist = [select accountId,lastname,Primary_Contact__c from contact 
                                     where accountId in: accids and Primary_Contact__c != null];
            map<id,integer> conmap = new map<id,integer>();
            if(conlist != null){
                
                for(contact con : conlist){
                    conmap.put(con.AccountId,conlist.size()); 
                }
                for(contact con : newCons){
                    if(con.Primary_Contact__c != null && conmap.containsKey(con.AccountId) && conmap.get(con.AccountId)>0)
                    {
                        con.addError('This account cannot have more than one primary contact');
                        
                    }
                }
            }   
        }      
    }
}