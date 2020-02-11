public class StoreSearch
{
    public List<SObject> products {public get;private set;}
    
    public string JsonProducts{public get;private set;}
    
	public static final SearchSettings settings = new SearchSettings();    
    
    public StoreSearch()
    {
        //string is whatever is coming from the force page 
        products = [select name, description from Product2];// Where name Like %'searchKey'%
        
        JsonProducts = JSON.Serialize(products);  
    }

    
    /**
     * Perform a search on records using the supplied searchTerms.
     * 
     * For scratch org development we need to return some sample records.
     */
    @RemoteAction
    public static Map<String, List<SObject>> GetQueryResults(string[] searchTerms)
    {
        String searchKey, searchQuery;
        
        List<SObject> products;
            
		List<SearchResult> results;
        
        searchKey = String.join(searchTerms,' ');
        
        /** Previous query **/
        // String searchQuery='select Name,id,description, from product2 where name like \'%'+searchKey+'%\' Limit 100';
        
        
        searchQuery = 'SELECT Product2.Id, Product2.Name, Product2.Description, UnitPrice FROM PricebookEntry '+
            'WHERE Product2.Name LIKE \'%'+searchKey+'%\' LIMIT 100 OFFSET 0';
        
        products = Database.query(searchQuery);
        
        results = toSearchResults(products);
        
        // Return the results back to the client, keyed by the type of record.
        return new Map<string, List<SObject>>{'Product2' => products};
    }
    
    
    /**
     * Perform any standardization required in the results.
     * 
     * Override the SearchResult constructor as needed to supply default or necessary values.
     */
    public static List<SearchResult> toSearchResults(List<SObject> records){
        List<SearchResult> results = new List<SearchResult>();
        
        for(SObject r : records){
            results.add(new SearchResult((PricebookEntry)r));
        }
        
        return results;
    }
    
    
    
    /**
     * Example of an inner class (SearchResult.)
     * https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_test_data.htm
     */
    public class SearchResult {
        
        public Id Id;
        
        public String Name;
        
        public String Description;
        
        public Decimal UnitPrice;
        
        public SearchResult(PricebookEntry obj){
            this.Id = obj.Id;
            this.Name = obj.Product2.Name;
            this.Description = obj.Product2.Description;
            this.UnitPrice = obj.UnitPrice;
        }
    }
}