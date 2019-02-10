public class AccountWrapper implements Comparable{
    
    public String  Name;
    public String  Type;
    public Double  AnnualRevenue;
    
    public AccountWrapper(Account Acc){
        
        Name            = Acc.Name;
        Type            = Acc.Type;
        AnnualRevenue   = Acc.AnnualRevenue;
        
    }

    public Integer compareTo(Object compareTo){
        AccountWrapper compareToAccount = (AccountWrapper)compareTo;
        
        if(AnnualRevenue == compareToAccount.AnnualRevenue){                
            return 0;
        } else if(AnnualRevenue == null ||  AnnualRevenue < compareToAccount.AnnualRevenue){
            return 1;
        } else {
            return -1;
        }
    }

}