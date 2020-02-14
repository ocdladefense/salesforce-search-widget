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
    public static Map<String, List<SearchResult>> GetQueryResults(string[] searchTerms, string filter)
    {
        if(filter == null) {
            return QueryNoFilter(searchTerms);
        } else {
            return QueryWithFilter(searchTerms, filter);
        }
    }
    
    private static Map<String, List<SearchResult>> QueryNoFilter (string[] searchTerms) {
        String searchKey, searchQuery;
        
        List<SObject> products;
            
		List<SearchResult> results;
        
        searchKey = String.join(searchTerms,' ');
        
        /** Previous query **/
        // String searchQuery='select Name,id,description, from product2 where name like \'%'+searchKey+'%\' Limit 100';
        
        
        searchQuery = 'SELECT Id, Name, Description FROM Product2 '+
            'WHERE Name LIKE \'%'+searchKey+'%\' LIMIT 100 OFFSET 0';
        
        products = Database.query(searchQuery);
        

        
        if(SearchSettings.USE_SAMPLE_DATA){
            results = getSampleResults();
        } else {
            results = toSearchResults(products);
        }

        return new Map<String, List<SearchResult>>{'Product2' => results};
    }

    private static Map<String, List<SearchResult>> QueryWithFilter (string[] searchTerms, string filter) {
        String searchKey, searchQuery;
        
        List<SObject> products;
            
		List<SearchResult> results;
        
        searchKey = String.join(searchTerms,' ');
        
        /** Previous query **/
        // String searchQuery='select Name,id,description, from product2 where name like \'%'+searchKey+'%\' Limit 100';
        
        
        searchQuery = 'SELECT Id, Name, Description FROM Product2 '+
            'WHERE Name LIKE \'%'+searchKey+'%\' LIMIT 100 OFFSET 0';
        
        products = Database.query(searchQuery);
        

        
        if(SearchSettings.USE_SAMPLE_DATA){
            results = getSampleResults();
        } else {
            results = toSearchResults(products);
        }

        return new Map<String, List<SearchResult>>{'Product2' => results};
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
     * Generate some sample data in case we need it for testing.
     */
    public static List<SearchResult> getSampleResults(){
        List<SearchResult> results = new List<SearchResult>();
        
        for(Integer i = 0; i<25; i++){
            SearchResult r = new SearchResult();
            r.Id = 'ABCD1234-'+i;
            r.Name = 'My Sample Product - '+i;
            r.Description = 'Sample Description - '+i;
            r.UnitPrice = 125.00 + i;
            
            results.add(r);
        }
        
        return results;
    }
    
    
    /**
     * Example of an inner class (SearchResult.)
     * https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_test_data.htm
     */
    public class SearchResult {
        
        public String Id;
        
        public String Name;
        
        public String Description;
        
        public Decimal UnitPrice;
        
        public SearchResult(PricebookEntry obj){
            this.Id = obj.Id;
            this.Name = obj.Product2.Name;
            this.Description = obj.Product2.Description;
            this.UnitPrice = obj.UnitPrice;
        }
        
        public SearchResult(){}
    }
}