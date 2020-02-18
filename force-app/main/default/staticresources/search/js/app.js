
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

	function sendUserInputToSearchManager()
	{
		manager.execute(userInput, filterInput());
		console.log(userInput);
	}
	
	// Wait a bit before sending typed input to the server.
	timerId = setTimeout(sendUserInputToSearchManager,350);
}


document.addEventListener("DOMContentLoaded", function(event){
	 document.getElementById('searchInputBox').addEventListener('input',acceptUserInput,true);

	 var searchWidget = document.getElementById(WIDGET_CONTAINER);
	 // document.getElementById(RESULTS_CONTAINER).innerHTML=NO_SEARCH_RESULT_STRING;
	 searchWidget.addEventListener("click", checkEvent,true);		   			   
 });

