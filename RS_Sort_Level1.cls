public class RS_Sort_Level1{
    
    public static list<Account> sortByRevenue(){
        
        List<Account> accounts          = new List<Account>();
        List<Account> accountsAfterSort = new List<Account>();
                
        list<Double> revenews           = new list<Double>();
        list<Double> revenewsDesc       = new list<Double>();
        
        map<Double,list<Account>> revVsAccounts = new map<Double,list<Account>>();
        
        accounts = [SELECT  AnnualRevenue, Name 
                      FROM  ACCOUNT
                  // WHERE  Active__c = 'Yes'                     
                   ];
        
        
        for(Account A : accounts){
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
        
        for(Double rev : revenewsDesc){         
            accountsAfterSort.add(revVsAccounts.get(rev)[0]);
            if(revVsAccounts.get(rev).size()>1) {
                revVsAccounts.get(rev).remove(0);
            }
        }
        
        for(Account A : accounts) system.debug(A.name +'  - '+A.AnnualRevenue); 
        system.debug('========= AFTER SORT ===========');
        for(Account A : accountsAfterSort) system.debug(A.name +' - '+A.AnnualRevenue); 
        
        return accountsAfterSort;
    }
}