
var SearchManagerPrototype = 
{
    doSearch:function(params, filter)
    {

        if(!(params instanceof Search)){
            search = params.search;
            filter = params.filter;
        } else{
            search = params;
        }


        console.log(search.getTerms());
        if(!(search.getTerms().length > 0)) return false;

		this.searchHistory.push(search);
        
        var request = new Promise(function(resolve,reject) {
            StoreSearch.GetQueryResults(search.getParameters(), filter.getFilter(), function(result, event){
                if (event.status){ resolve(result); }
                else { reject(result,event); }
            },
            {escape: true});
        });
        
        request.then(function(json) {
        	console.log(json);
        	if(!json || json.length < 1) return [];
					var parsedResults = renderHtml(json);
					document.getElementById(RESULTS_CONTAINER).innerHTML = ("<h1>Search Results</h1>"+parsedResults);
        })
        .then(function(json) {
            // this.resultsHistory.push(json);
        });
    },
    execute:function(searchString, filterString)
    {
        var search = new Search(searchString);
        var filter = new Filter(filterString);
        this.doSearch(search, filter);
    },

    resultsHasHistory:function()
    {
        if(this.resultsHistory[0] != "")
        return true;
    },
    searchHasHistory:function()
    {
        if(this.searchHistory[0] != "")
        return true;
    },
    getHistory:function(index)
    {
        if(index == SearchManager.LAST_HISTORY_SEARCH_RESULT){
            return this.searchHistory[this.searchHistory.length - 1];
        }

        return this.searchHistory[index];
    },
    getResultHistory:function(index)
    {
        return this.resultsHistory[index];
    }
};
var SearchManager = function()
{
    this.searchHistory = [];
    this.resultsHistory = [];
};
SearchManager.LAST_HISTORY_SEARCH_RESULT = -1;
SearchManager.prototype = SearchManagerPrototype;

