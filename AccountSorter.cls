public class AccountSorter { 
    
    public AccountSorter(){
        List<AccountWrapper> accWrpList = new List<AccountWrapper>();
        List<Account> accounts = [SELECT    Name,Type,AnnualRevenue 
                                    FROM    Account
                                   //WHERE    Active__c = 'Yes'
                                   //ORDER BY 
                                   LIMIT 50000
                                    ];
        
        for(Account A : accounts){
            accWrpList.add(new AccountWrapper(A));
        }
        
        for(AccountWrapper AW : accWrpList){
            system.debug(AW.AnnualRevenue +' - '+AW.Type +' - '+AW.Name);
        }
        
        accWrpList.sort();
        
        system.debug('================= AFTER Sorting ==================');
        for(AccountWrapper AW : accWrpList){
            system.debug(AW.AnnualRevenue +' - '+AW.Type +' - '+AW.Name);
        }
    }

}