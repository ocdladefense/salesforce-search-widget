public class StoreSearch
{
    public List<SObject> products {public get;private set;}
    
    public string JsonProducts{public get;private set;}
    
    public static final SearchSettings settings = new SearchSettings();

    public List<SelectOption> FamilyOptions { get { return FillFamilySelect(); }}
    
    public List<AggregateResult> families {get; set;}
    
    public StoreSearch()
    {
        //string is whatever is coming from the force page 
        products = [select name, description from Product2];// Where name Like %'searchKey'%
        
        JsonProducts = JSON.Serialize(products);  
    }

    public String GetFamilySelect() {
        return JSON.serialize(new Map<String,String>{'Event' => 'Event Ticket', 'Donation' => 'Donation'});
    }

   public List<SelectOption> FillFamilySelect() {
        families = Database.Query(settings.familyQuery);
        List<SelectOption> familySelectOptions = new List<SelectOption>();
        // Add a default SelectOption "all" that sets filter to null
        familySelectOptions.add(new SelectOption('All', 'All'));
        String family;
        for(AggregateResult ar : families) {
            if(ar != null) {
                family = (String)ar.get('Family');
                if(family != 'null' && family != null) {
                    familySelectOptions.add(new SelectOption(family, family));
                }
            }
        }
        return familySelectOptions;
    } 

    
    /**
     * Perform a search on records using the supplied searchTerms.
     * 
     * For scratch org development we need to return some sample records.
     */
    @RemoteAction
    public static List<SearchResult> GetQueryResults(string[] searchTerms, string filter)
    {
        if(filter == null) {
            return QueryNoFilter(searchTerms);
        } else {
            return QueryWithFilter(searchTerms, filter);
        }
    }


    
    private static List<SearchResult> QueryNoFilter (string[] searchTerms) {
        String searchQuery;
        
        String filter = null;

        List<SObject> products;
            
		List<SearchResult> results;
        
        // String searchKey = String.join(searchTerms,' ');  

        // searchQuery = 'SELECT Product2.Id, Product2.Name, Product2.Description, Product2.Family FROM Product2 '+
        //     'WHERE Product2.Name LIKE \'%'+searchKey+'%\' LIMIT 100 OFFSET 0';

        // Build the query using a null filter
        QueryBuilder qb = QueryBuilder.NewFromSettings(settings.targetObject, settings.returnFields);
        
        // new QueryBuilder(searchTerms, filter);
        
        searchQuery = qb.Compile();
        
        products = Database.query(searchQuery);
        
        if(SearchSettings.USE_SAMPLE_DATA){
            results = getSampleResults();
        } else {
            results = toSearchResults(products);
        }

        return results;
    }

    private static List<SearchResult> QueryWithFilter (string[] searchTerms, string filter) {
        String searchQuery;
        
        List<SObject> products;
            
		List<SearchResult> results;
        
        // String searchKey = String.join(searchTerms,' ');
        
        // searchQuery = 'SELECT Product2.Id, Product2.Name, Product2.Description, Product2.Family FROM Product2 '+
        // 'WHERE Product2.Name LIKE \'%'+ searchKey +'%\' AND Product2.Family = \'' + filter + '\' LIMIT 100 OFFSET 0';

        QueryBuilder qb = QueryBuilder.NewFromSettings(settings.targetObject, settings.returnFields);
        
        searchQuery = qb.compile();
        
        if(SearchSettings.USE_SAMPLE_DATA){
            results = getSampleResults();
        } else {
            results = toSearchResults(products);
        }

        return results;
    }
    
    /**
     * Perform any standardization required in the results.
     * 
     * Override the SearchResult constructor as needed to supply default or necessary values.
     */
    public static List<SearchResult> toSearchResults(List<SObject> records){
        List<SearchResult> results = new List<SearchResult>();
        
        for(SObject r : records){
            results.add(new SearchResult((Product2) r));
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

        public String Family;
        
        public SearchResult(Product2 obj){
            this.Id = obj.Id;
            this.Name = obj.Name;
            this.Description = obj.Description;
            this.UnitPrice = 125.00;
            this.Family = obj.Family;
        }
        
        public SearchResult(){}
    }
}