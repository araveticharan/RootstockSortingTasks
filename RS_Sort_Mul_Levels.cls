public class RS_Sort_Mul_Levels{
    
    public static list<Account> sortByRevenueTypeName(){
        
        List<Account> accounts          = new List<Account>();
        List<Account> accountsAfterSort = new List<Account>();
                
        
        accounts = [SELECT  AnnualRevenue ,Name ,Type
                      FROM  ACCOUNT
                     //WHERE  Active__c = 'Yes'                   
                   ];
        for(Account A : accounts) system.debug(A.AnnualRevenue+' - '+A.Type+'  - '+A.name);
        
        
        //accountsAfterSort.addAll(sortList(accounts,'Revenue'));
        accountsAfterSort = sortList(accounts,'Revenue');
        
        system.debug('========= AFTER FINAL SORT ===========');
        for(Account A : accountsAfterSort) system.debug(A.AnnualRevenue+' - '+A.Type+'  - '+A.name); 
        
        return accountsAfterSort;
    
    }
    
    private static list<Account> sortList(list<Account> acccountsToSort, String sortBy){
        List<Account> accountsAfterSort = new List<Account>();
        
        if(sortBy == 'Revenue'){
            
            list<Double> revenews           = new list<Double>();
            list<Double> revenewsDesc       = new list<Double>();
            
            map<Double,list<Account>> revVsAccounts = new map<Double,list<Account>>();
        
            for(Account A : acccountsToSort){
                revenews.add(A.AnnualRevenue);
                    
                if(revVsAccounts.containsKey(A.AnnualRevenue))
                    revVsAccounts.get(A.AnnualRevenue).add(A);
                else
                    revVsAccounts.put(A.AnnualRevenue, new List<Account>{A});
            }
            
            
            revenews.sort();
            
            
            for(Integer i =  revenews.size() -1; i >=0 ;  i--){
                revenewsDesc.add(revenews[i]);
            }
            
            for(Double rev : revVsAccounts.keySet()){           
                if(revVsAccounts.get(rev).size() == 1) continue;
                    
                revVsAccounts.put(rev, sortList(revVsAccounts.get(rev),'Type'));
                
            }
            
            for(Double rev : revenewsDesc){         
                accountsAfterSort.add(revVsAccounts.get(rev)[0]);
                if(revVsAccounts.get(rev).size()>1) {
                    revVsAccounts.get(rev).remove(0);
                }
            }
        }else if(sortBy == 'Type'){
            Map<String,List<Account>> typeVsAccounts = new Map<String,List<Account>>();
            List<String> types      = new List<String>();
            
            for(Account A : acccountsToSort){
                
                if(A.Type != NULL) types.add(A.Type);
                    
                if(typeVsAccounts.containsKey(A.Type))
                    typeVsAccounts.get(A.Type).add(A);
                else
                    typeVsAccounts.put(A.Type, new List<Account>{A});
            }
            
            types.sort();
            
            for(String type : typeVsAccounts.keySet()){         
                if(typeVsAccounts.get(type).size() == 1) continue;
                    
                typeVsAccounts.put(type, sortList(typeVsAccounts.get(type),'Name'));
                
            }
            
            for(string type : types){
                accountsAfterSort.add(typeVsAccounts.get(type)[0]);
                if(typeVsAccounts.get(type).size()>1) {
                    typeVsAccounts.get(type).remove(0);
                }
            }
            
            
            if(typeVsAccounts.containsKey(null)) accountsAfterSort.addAll(typeVsAccounts.get(null));
            
            //system.debug('========= AFTER SORT BY TYPE===========');
            //for(Account A : accountsAfterSort) system.debug(A.name +' - '+A.AnnualRevenue +' - '+A.Type);
            
            
        }else if(sortBy == 'Name'){
            Map<String,List<Account>> nameVsAccounts = new Map<String,List<Account>>();
            List<String> types      = new List<String>();
                
            for(Account A : acccountsToSort){
                
                if(A.Name != NULL) types.add(A.Name);
                    
                if(nameVsAccounts.containsKey(A.Name))
                    nameVsAccounts.get(A.Name).add(A);
                else
                    nameVsAccounts.put(A.Name, new List<Account>{A});
            }
            
            types.sort();
            
            for(string Name : types){
                accountsAfterSort.add(nameVsAccounts.get(Name)[0]);
                if(nameVsAccounts.get(Name).size()>1) {
                    nameVsAccounts.get(Name).remove(0);
                }
            }
            
            
            if(nameVsAccounts.containsKey(null)) accountsAfterSort.addAll(nameVsAccounts.get(null));
            
            //system.debug('========= AFTER SORT BY NAME ===========');
            //for(Account A : accountsAfterSort) system.debug(A.name +' - '+A.AnnualRevenue +' - '+A.Type);
        }
        
        
        
        return accountsAfterSort;
    }
    
    
}