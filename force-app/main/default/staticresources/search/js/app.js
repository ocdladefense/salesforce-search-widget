
var manager = new SearchManager();
var timerId;

function acceptUserInput(e)
{
	//Clear any previous timer
	clearTimeout(timerId);
	//Immediately start the timer after the first keystroke
	//But also start the timer after every keystroke
	//Any additional keystroke cancels the previous timer
	var userInput = e.target.value;

	var filterInput = function() {
		return null;
	}

	//var outputLabel = document.getElementById("outputLabel");
	//outputLabel.classList.add("loader");

	function sendUserInputToSearchManager()
	{
		manager.execute(userInput, filterInput());
		console.log(userInput);
	}
	
	// Wait a bit before sending typed input to the server.
	timerId = setTimeout(sendUserInputToSearchManager,350);
}

function onFilterChange(e)
{
	var target = e.target;

	var value = target.value;

	// Could reasess value of input field, alternatively use input history 
	
	var previous = manager.getHistory(SearchManager.LAST_HISTORY_SEARCH_RESULT);

	manager.doSearch(previous, new Filter(value));

	
}

document.addEventListener("DOMContentLoaded", function(event){
	 document.getElementById('searchInputBox').addEventListener('input',acceptUserInput,true);
	 document.getElementById('families-select').addEventListener('change', onFilterChange, true);
	 document.addEventListener('click', function (e){
		 window.alert(e.target.nodeName + "capture phase");
	 },true);

	 document.addEventListener('click', function (e){
		window.alert(e.target.nodeName + "target phase");
	},false);

	 var searchWidget = document.getElementById(WIDGET_CONTAINER);
	 // document.getElementById(RESULTS_CONTAINER).innerHTML=NO_SEARCH_RESULT_STRING;
	 searchWidget.addEventListener("click", checkEvent,true);		   			   
 });

