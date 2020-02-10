public class StoreSearch
{
    public List<SObject> products {public get;private set;}
    
    public string JsonProducts{public get;private set;}
    
    
    
    public StoreSearch()
    {
        //string is whatever is coming from the force page 
        products = [select name, description from Product2];// Where name Like %'searchKey'%
        
        JsonProducts = JSON.Serialize(products);  
    }
    
    @RemoteAction
    public static Map<string, List<SObject>>GetQueryResults(string[] searchTerms)
    {
        String searchKey;
        
        searchKey = String.join(searchTerms,' ');
        
        /** Previous query **/
        // String searchQuery='select Name,id,description, from product2 where name like \'%'+searchKey+'%\' Limit 100';
        
        
        String searchQuery = 'SELECT Product2.Id, Product2.Name, Product2.Description, UnitPrice, StandardPrice, Discounts__c FROM PricebookEntry '+
            'WHERE Product2.Name LIKE \'%'+searchKey+'%\' LIMIT 100 OFFSET 0';
        
        List<SObject> products = Database.query(searchQuery);
        
        return new Map<string, List<SObject>>{'Product2' => products};
    }
}