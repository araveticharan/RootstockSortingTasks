public class AccountSorterMul { 
    
    public AccountSorterMul(){
        List<AccountWrapperMul> AccountWrapperMul = new List<AccountWrapperMul>();
        List<Account> accounts = [SELECT    Name,Type,AnnualRevenue 
                                    FROM    Account
                                   //WHERE    Active__c = 'Yes'
                                   //ORDER BY 
                                   LIMIT 50000
                                    ];
        
        for(Account A : accounts){
            AccountWrapperMul.add(new AccountWrapperMul(A));
        }
        
        for(AccountWrapperMul AW : AccountWrapperMul){
            system.debug(AW.AnnualRevenue +' - '+AW.Type +' - '+AW.Name);
        }
        
        system.debug('================= Before SORTING  ==================');
        
        AccountWrapperMul.sort();
        
        system.debug('================= AFTER Sorting ==================');
        for(AccountWrapperMul AW : AccountWrapperMul){
            system.debug(AW.AnnualRevenue +' - '+AW.Type +' - '+AW.Name);
        }
    }
    
   

}