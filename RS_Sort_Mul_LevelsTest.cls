/**************************************************************************************************

Test Classes may fail as Type is PickList and the SalesForce limitaion mentioed in 
https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_select_orderby.htm

As a workaround create a formula field like Type__c with formula TEXT(Type) 
***************************************************************************************************/
@isTest
private class RS_Sort_Mul_LevelsTest {
    @testSetup static void setupTestData() {
        List<Account> accounts  = new List<Account>();
        
        
        accounts.add(new Account(AnnualRevenue  = 234234.0 ,Type='Prospect'             ,Name = 'A1'));
        accounts.add(new Account(AnnualRevenue  = 234234.0 ,Type='Prospect'             ,Name = 'A02'));
        accounts.add(new Account(AnnualRevenue  = 7863432.0,Type='Prospect'             ,Name = 'A3'));
        accounts.add(new Account(AnnualRevenue  = 234234.0 ,Type='Customer'             ,Name = 'A4'));     
        accounts.add(new Account(AnnualRevenue  = 234234.0 ,Type='Installation Partner' ,Name = 'A5'));
        //accounts.add(new Account(AnnualRevenue  = 234234.0                            ,Name = 'A6'));
        //accounts.add(new Account(AnnualRevenue  = 354.0                               ,Name = 'A8'));
            
        INSERT accounts;
        
    }
    
    public static testmethod void withOutNullTest() { 
        List<Account> sortedAccounts = RS_Sort_Mul_Levels.sortByRevenueTypeName();
        
        system.debug('================= withOutNullTest ===============');
        
        for(Account A : sortedAccounts) system.debug(A.AnnualRevenue+' - '+A.Type+'  - '+A.name); 
        
        List<Account> orderedAccountsFromDB = new List<Account>();
        
        /*orderedAccountsFromDB  = [  SELECT  AnnualRevenue, Type, Name
                                      FROM  Account
                                  ORDER BY  AnnualRevenue Desc NULLS LAST​, Type ASC NULLS LAST​,Name ASC NULLS LAST​
                                ];
        */
        
        orderedAccountsFromDB  = [SELECT  AnnualRevenue, Type, Name
                                    FROM  Account
                                ORDER BY  AnnualRevenue Desc NULLS LAST, Type Asc NULLS LAST, Name Asc NULLS LAST  
                                    ];
        
        system.debug('================= withOutNullTest DB ===============');
        for(Account A : orderedAccountsFromDB) system.debug(A.AnnualRevenue+' - '+A.Type+'  - '+A.name);        
                                    
        for(Integer i = 0; i < sortedAccounts.size();i++){
            //system.assertEquals(orderedAccountsFromDB[i].Name,sortedAccountsByRev[i].Name);
            
        }
        
    }
    
    public static testmethod void withnullTest() { 
        List<Account> sortedAccountsByRev = RS_Sort_Mul_Levels.sortByRevenueTypeName();
        
        List<Account> accounts  = new List<Account>();
        
        accounts.add(new Account(AnnualRevenue  = 234234.0,Name = 'A6'));
        accounts.add(new Account(AnnualRevenue  = 354.0   ,Name = 'A8'));
        accounts.add(new Account(                          Name = 'A7'));
        accounts.add(new Account(                          Name = 'A9'));
            
        INSERT accounts;
        
        List<Account> orderedAccountsFromDB = new List<Account>();
        
        orderedAccountsFromDB  = [SELECT  AnnualRevenue, Type, Name
                                    FROM  Account
                                ORDER BY  AnnualRevenue Desc NULLS LAST, Type Asc NULLS LAST, Name Asc NULLS LAST  
                                    ];
        
        for(Integer i = 0; i < sortedAccountsByRev.size();i++){
            system.assertEquals(orderedAccountsFromDB[i].Name,sortedAccountsByRev[i].Name);
        }
        
        
    }
    
    
    
    public static testmethod void AccountWrapperTest(){
        List<Account> accounts                  = new List<Account>();
        List<AccountWrapperMul> AccountWrappers = new List<AccountWrapperMul>();
        
        accounts.add(new Account(AnnualRevenue  = 234234.0,Name = 'A6'));
        accounts.add(new Account(AnnualRevenue  = 354.0   ,Name = 'A8'));
        accounts.add(new Account(                          Name = 'A7'));
        accounts.add(new Account(                          Name = 'A9'));
            
        INSERT accounts;
        
        
        list<Account> accountsWO_orderByFromDB = new list<Account>([SELECT  AnnualRevenue, Type, Name FROM  Account]);
        
        if(!accountsWO_orderByFromDB.isEmpty()){
            for(Account A:accountsWO_orderByFromDB)  AccountWrappers.add(new AccountWrapperMul(A));
            
            AccountWrappers.sort();
            
            List<Account> orderedAccountsFromDB = new List<Account>();
        
            orderedAccountsFromDB  = [SELECT  AnnualRevenue, Type, Name
                                        FROM  Account
                                    ORDER BY  AnnualRevenue Desc NULLS LAST, Type Asc NULLS LAST, Name Asc NULLS LAST  
                                    ];
            
            for(Integer i = 0; i < AccountWrappers.size();i++){
                system.assertEquals(orderedAccountsFromDB[i].Name,AccountWrappers[i].Name);
            }
            
        }
    }
    
}