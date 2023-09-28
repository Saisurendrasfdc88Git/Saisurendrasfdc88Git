//Scenario 15: Show Min&Max Salary of Employee(Contact) records on Parent Company(Account) Record
/*in Details : we have two objects which are employee and company,in employee object we have a field called salary, in company object we have a fields those are MinSalary & MaxSalary
we have to display minsalary and maxsalary of an employees which are associated with the company*/

public class SCXV {
    
    public static void getSalary(list<contact> newCons,map<id,contact> oldCons){
        set<id> accids = new set<id>();
        
        if(!newCons.isEmpty()){
            
            for(contact con : newCons){
                
                if(oldCons!=null){
                    
                    contact oldCon = oldCons.get(con.id);
                    
                    if(con.AccountId != oldcon.AccountId){                       
                        accids.add(oldcon.AccountId);
                        accids.add(con.AccountId);                                           
                    } 
                    else{
                        accids.add(con.AccountId);
                    }                    
                }
                else{
                    accids.add(con.AccountId);
                }              
            }
        }    
        list<aggregateResult> aggrl = [ select accountId ids,max(salary__c) maxsalary,min(salary__c) minsalary from contact 
                                       where AccountId In:accids group by accountId];
        map<id,account> accmap = new map<id,account>();
        
        for(aggregateResult aggr : aggrl){
            account acc = new account();
            acc.id = (id)aggr.get('ids');
            acc.Max_Salary__c=(decimal)aggr.get('maxsalary');
            acc.Min_Salary__c=(decimal)aggr.get('minsalary');
            accmap.put(acc.id,acc);
        }
        if(!accmap.isEmpty()){
            update accmap.values();
        }       
    }
}