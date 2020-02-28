public class StoreSearch
{
    public List<SObject> products {public get;private set;}
    
    public String JsonProducts {public get;private set;}
    
    public static final SearchSettings settings = new SearchSettings();

    public List<SelectOption> FamilyOptions { get { return FillFamilySelect(); }}
    
    public List<AggregateResult> families {get; set;}
    
    
    // Default constructor.
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
    public static List<SearchResult> GetQueryResults(String[] terms, String filter)
    {
    
        List<SObject> products;
            
				List<SearchResult> results;
        
        
        // Build the query using a null filter
        QueryBuilder qb = QueryBuilder.NewFromSettings(settings.targetObject, settings.returnFields);
        
        qb.addCondition(new SqlCondition('Name',String.join(terms,Sql.TOKEN_SEPARATOR),Sql.OPERATOR_LIKE));
        
        qb.addCondition(new SqlCondition('Family',NULL,Sql.OP_NEQ));
        
        qb.orderBy('Name');
        qb.setLimit(100);

        
        
        products = Database.query(qb.Compile());
        

        return SearchSettings.USE_SAMPLE_DATA ? getSampleResults() : toSearchResults(products);
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