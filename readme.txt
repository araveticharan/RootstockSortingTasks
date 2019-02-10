==========================================================
===============    Problem statement:  ===================
==========================================================
  SELECT AnnualRevenue, Type, Name
    FROM Account
ORDER BY AnnualRevenue Desc NULLS LAST
---------------------------------------------------------------

RS_Sort_Level1 		- Using Sort() method 
AccountWrapper 		- Using Comparable interface	
AccountSorter  		- Not Important - Which uses AccountWrapper
RS_Sort_Level1Test	- Test Class



============================================================
===================   Extra credit:     ====================
============================================================

  SELECT AnnualRevenue, Type, Name
    FROM Account
ORDER BY AnnualRevenue Desc NULLS LAST, 
	     Type Asc NULLS LAST,
		 Name Asc NULLS LAST ​
------------------------------------------------------------
RS_Sort_Mul_Levels 		- Using Sort() method 
AccountWrapperMul		- Using Comparable interface	
AccountSorterMul		- Not Important - Which uses AccountWrapperMul
RS_Sort_Mul_LevelsTest		- Test Class
				  This Test Class may fail as Type is PickList and SalesForce limitaion mentioed in 
				  https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_select_orderby.htm
				  As a workaround create a formula field likr Type__c with formula TEXT(Type) 

