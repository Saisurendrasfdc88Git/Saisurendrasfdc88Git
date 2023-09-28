//Saisurendra Seshapu
public class SCXVIHandler {
    
    public static void HighestOpp(list<opportunity> NewOpps,Map<id,opportunity> oldOpps){
        
        set<id> accids = new set<id>();
        if(!NewOpps.isEmpty()){
            
            for(Opportunity Newopp : NewOpps){
                
                if(oldOpps != null){   
                    Opportunity oldOpp = oldOpps.get(Newopp.Id);
                    if(oldOpp !=null){
                    if(Newopp.AccountId != oldOpp.AccountId){
                        accids.add(oldOpp.AccountId);
                        accids.add(Newopp.AccountId);
                    }
                    else{
                        accids.add(Newopp.AccountId);
                    }
                    }
                }
                else{
                    accids.add(Newopp.AccountId);
                }
                
                list<account> acclist = [select Max_Opp__c,(select id,name,amount,accountId from opportunities 
                                                            where amount !=null order by amount desc limit 1) from account where id in: accids];
                list<account> UpdateAcc = new list<account>();
                if(!acclist.isEmpty()){                  
                    for(account acc : acclist){
                        if(!acc.opportunities.isEmpty()){
                            acc.Max_Opp__c = acc.opportunities[0].Name;
                            UpdateAcc.add(acc);
                        }
                        else{
                            acc.Max_Opp__c='';
                            UpdateAcc.add(acc);
                        }
                        
                    }                   
                }
                if(!UpdateAcc.isEmpty()){
                    update UpdateAcc;
                }    
            }    
        }    
    }  
}