@IsTest
public with sharing class SearchUnitTests {
    //@TestMethod(SeeAllData=true)
    @TestSetup
    static void makeData(){
        Product2 product1 = new Product2(name='OCDLA Calendar');
        Product2 product2 = new Product2(name='DUII Trial Notebook');

        Insert product1;
        Insert product2;
    }

    @IsTest
    private static void getAllProducts() {
        //not currently possible, but should be possible
        //should be able to set filter to "all" and type nothing in the search box and all products should show up
    }

    @IsTest
    private static void returnZeroProducts() {
        List<String> searchTerms = new List<String>{'product'};
        String filter = null;
        
        List<StoreSearch.SearchResult> results = StoreSearch.GetQueryResults(searchTerms, filter);


        System.assert(null != results);
        System.assert(results.size() == 0);
    }
}
