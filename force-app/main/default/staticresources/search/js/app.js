
var manager = new SearchManager();
var timerId;
var currentFilter = null;

function getInput(e)
{
	var eventType = e.type;
	var target = e.target;

	var defaultSearch = 
	{
		search: new Search(""),
   
		filter: new Filter()
	};

	//Clear any previous timer
	clearTimeout(timerId);

	//Immediately start the timer after the first keystroke
	//But also start the timer after every keystroke
	//Any additional keystroke cancels the previous timer
	// var userInput = e.target.value;
	var searchInput = function() {
		var inputBox = document.getElementById('searchInputBox');
		var value = inputBox.value;
		if (!value) {
			value = "";
		}
		console.log("Search Box Value: " + value);
		return value;
	}

	var filterInput = function() {
		var select = document.querySelector('select[id *= "family-select"]');
		var value = select.options[select.selectedIndex].value;
		if(value == "All") {
			value = null;
		}
		console.log("Filter Value: " + value);
		return value;
	}

	//var outputLabel = document.getElementById("outputLabel");
	//outputLabel.classList.add("loader");

	// --- MARKED FOR DELETION
	// function sendUserInputToSearchManager()
	// {
	// 	manager.execute(searchInput(), filterInput());
	// }

	if(eventType == "change"){
		defaultSearch.filter = new Filter(filterInput());

		// check the history for last search
		defaultSearch.search = manager.getHistory(SearchManager.LAST_HISTORY_SEARCH_RESULT);

		// if there is no history, create a new search
		if(!defaultSearch.search) {
			defaultSearch.search = new Search(searchInput());
		}

		manager.doSearch(defaultSearch);
	} 
	else if(eventType == "input") {
		defaultSearch.filter = new Filter(filterInput())
		defaultSearch.search = new Search(searchInput());

		// Wait a bit before sending typed input to the server.
		timerId = setTimeout(function(){ manager.doSearch(defaultSearch)}, 350);
	} else if (eventType == "DOMContentLoaded") {
		defaultSearch.filter = new Filter(filterInput());
		defaultSearch.search = new Search(searchInput());
		manager.doSearch(defaultSearch);
	}
	
	
}

document.addEventListener("DOMContentLoaded", function(event){
	//run the initial search on page load (Filter = all, Search = "")
	getInput(event);


	document.addEventListener('input', getInput, true);
	document.addEventListener('change', getInput, true);

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