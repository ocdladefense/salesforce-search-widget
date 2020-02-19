
var manager = new SearchManager();
var timerId;

function searchInput(e)
{
	var eventType = e.type;
	var target = e.target;

	var defaultSearch = 
	{
		search: new Search("test"),
   
		filter: new Filter()
	};

	//Clear any previous timer
	clearTimeout(timerId);

	//Immediately start the timer after the first keystroke
	//But also start the timer after every keystroke
	//Any additional keystroke cancels the previous timer
	//var outputLabel = document.getElementById("outputLabel");
	//outputLabel.classList.add("loader");

	if(eventType == "change"){
		defaultSearch.filter = new Filter(target.value);

		// Could reasess value of input field, alternatively use input history 
	
		defaultSearch.search = manager.getHistory(SearchManager.LAST_HISTORY_SEARCH_RESULT);

		manager.doSearch(defaultSearch);
	} 
	else if(eventType == "input") {

		defaultSearch.search = new Search(target.value);

		// Wait a bit before sending typed input to the server.
		timerId = setTimeout(function(){ manager.doSearch(defaultSearch)}, 350);
	} 

	
	
}

document.addEventListener("DOMContentLoaded", function(event){
	 document.addEventListener('input',searchInput,true);
	 document.addEventListener('change', searchInput, true);

	 var searchWidget = document.getElementById(WIDGET_CONTAINER);
	 // document.getElementById(RESULTS_CONTAINER).innerHTML=NO_SEARCH_RESULT_STRING;
	 searchWidget.addEventListener("click", checkEvent,true);		   			   
 });


 /*
 var searchForDuiEvents = 
 {
	 search : new Search("dui"),

	 filter : new Filter("events")
 };
 var searchForDuiManuals = 
 {
	 search : manager.getHistory(SearchManager.LAST_HISTORY_SEARCH_RESULT),

	 filter : new Filter("manuals")
 };
 var searchForAll = 
 {
	 search : manager.getHistory(SearchManager.LAST_HISTORY_SEARCH_RESULT),

	 filter : new Filter()
 }; */