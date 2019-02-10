/*====================================================================
  
  SELECT AnnualRevenue, Type, Name
    FROM Account
ORDER BY AnnualRevenue Desc NULLS LAST, 
         Type Asc NULLS LAST,
         Name Asc NULLS LAST ​
         
====================================================================*/

public class AccountWrapperMul implements Comparable{
    
    public String  Name;
    public String  Type;
    public Double  AnnualRevenue;
    
    public AccountWrapperMul(Account Acc){      
        Name            = Acc.Name;
        Type            = Acc.Type;
        AnnualRevenue   = Acc.AnnualRevenue;        
    }

    public Integer compareTo(Object compareTo){
        AccountWrapperMul compareToAccount = (AccountWrapperMul)compareTo;
        
        
        
        if(AnnualRevenue == compareToAccount.AnnualRevenue){    
            
            if(Type  == compareToAccount.Type) {
                if(Name  == compareToAccount.Name) return 0;
                if(Name  == null) return 1;
                if(compareToAccount.Name == null) return -1;
                
                return Name.compareTo(compareToAccount.Name);
            }
            if(Type  == null) return 1;
            if(compareToAccount.Type == null) return -1;
            
            return Type.compareTo(compareToAccount.Type); 
                
        } else if(AnnualRevenue == null ||  AnnualRevenue < compareToAccount.AnnualRevenue){
            return 1;
        } else {
            return -1;
        }
    }
}