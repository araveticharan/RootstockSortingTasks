@isTest
private class RS_Sort_Level1Test {
    @testSetup static void setupTestData() {
        List<Account> accounts  = new List<Account>();
        
        
        accounts.add(new Account(AnnualRevenue  = 234234.0 ,Type='Prospect'             ,Name = 'A1'));
        accounts.add(new Account(AnnualRevenue  = 234234.0 ,Type='Prospect'             ,Name = 'A02'));
        accounts.add(new Account(AnnualRevenue  = 7863432.0,Type='Prospect'             ,Name = 'A3'));
        accounts.add(new Account(AnnualRevenue  = 234234.0 ,Type='Customer'             ,Name = 'A4'));     
        accounts.add(new Account(AnnualRevenue  = 234234.0 ,Type='Installation Partner' ,Name = 'A5'));
        accounts.add(new Account(AnnualRevenue  = 234234.0                              ,Name = 'A6'));
        accounts.add(new Account(AnnualRevenue  = 354.0                                 ,Name = 'A8'));
            
        INSERT accounts;
        
    }
    
    public static testmethod void withOutNullTest() { 
        List<Account> sortedAccountsByRev = RS_Sort_Level1.sortByRevenue();
        
        List<Account> orderedAccountsFromDB = new List<Account>();
        
        orderedAccountsFromDB  = [SELECT  AnnualRevenue, Type, Name
                                    FROM  Account
                                ORDER BY  AnnualRevenue Desc NULLS LAST  
                                ];
        
        for(Integer i = 0; i < sortedAccountsByRev.size();i++){
            system.assertEquals(orderedAccountsFromDB[i].Name,sortedAccountsByRev[i].Name);
        }
        
    }
    
    public static testmethod void withnullTest() { 
        List<Account> sortedAccountsByRev = RS_Sort_Level1.sortByRevenue();
        
        List<Account> accounts  = new List<Account>();
        
        accounts.add(new Account(Name = 'A7'));
        accounts.add(new Account(Name = 'A9'));
            
        INSERT accounts;
        
        List<Account> orderedAccountsFromDB = new List<Account>();
        
        orderedAccountsFromDB  = [SELECT  AnnualRevenue, Type, Name
                                    FROM  Account
                                ORDER BY  AnnualRevenue Desc NULLS LAST  
                                ];
        
        for(Integer i = 0; i < sortedAccountsByRev.size();i++){
            system.assertEquals(orderedAccountsFromDB[i].Name,sortedAccountsByRev[i].Name);
        }
        
        
    }
    
    
    
    public static testmethod void AccountWrapperTest(){
        List<Account> accounts                  = new List<Account>();
        List<AccountWrapper> AccountWrappers    = new List<AccountWrapper>();
        
        accounts.add(new Account(Name = 'A7'));
        accounts.add(new Account(Name = 'A9'));
            
        INSERT accounts;
        
        
        list<Account> accountsWO_orderByFromDB = new list<Account>([SELECT  AnnualRevenue, Type, Name FROM  Account]);
        
        if(!accountsWO_orderByFromDB.isEmpty()){
            for(Account A:accountsWO_orderByFromDB)  AccountWrappers.add(new AccountWrapper(A));
            
            AccountWrappers.sort();
            
            List<Account> orderedAccountsFromDB = new List<Account>();
        
            orderedAccountsFromDB  = [SELECT  AnnualRevenue, Type, Name
                                        FROM  Account
                                    ORDER BY  AnnualRevenue Desc NULLS LAST  
                                    ];
            
            for(Integer i = 0; i < AccountWrappers.size();i++){
                system.assertEquals(orderedAccountsFromDB[i].Name,AccountWrappers[i].Name);
            }
            
        }
    }
    
}