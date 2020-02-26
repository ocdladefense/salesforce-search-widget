/**
 * Copy this file to SearchSettings.cls.
 * SearchSettings is a required class of the StoreSearch component.
 * 
 * Changes made to this (example) class are saved in the git repo
 *  for others to configure their own installations.
 */
public without sharing class SearchSettingsExample {

    // Used to query the "family" drop down list
    public string familyQuery = 'SELECT Family FROM Product2 GROUP BY Family';
    
    // Whether to use any mock data for search results.
    // Helpful when there is no sample data, i.e., in scratch orgs
    public static final Boolean USE_SAMPLE_DATA = True;
    
    
    // Fields that will be returned as part of the search.
    String[] fields = new String[]{'Product2.Id','Product2.Name',
        'Product2.Description', 'UnitPrice'};
            
            
	// Which objects are we searching.
    String[] targetObjects =  new String[]{'PricebookEntry'};
           
        
	// Filter parameters make our filter string easier to read.
	List<Object> params = new List<Object>();
        
    
	// Run this through String.format using params, above, 
	String filter =   'WHERE Product2.Name LIKE \'%{0}%\' LIMIT 100 OFFSET 0';                                 
    
    
    // Default constructor.
    public SearchSettingsExample() {}
}