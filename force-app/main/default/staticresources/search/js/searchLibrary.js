
function renderHtml(json) 
{
	var parsedResults="";
	for(var sobjectname in json){
		for(i = 0; i<json[sobjectname].length; i++)
		{
			var cResult = json[sobjectname][i];
			cResult.sobjectname = sobjectname;
			var prodHtml = !!CUSTOM_RESULT_RENDERER ? CUSTOM_RESULT_RENDERER(cResult) : DEFAULT_RESULT_RENDERER(cResult);
			parsedResults += prodHtml;
		}
	}
	return parsedResults;
}

function checkEvent(e){

	e.stopPropagation();
	e.preventDefault();

	// Reference to clicked element
	var target = e.target;
	var href = target.getAttribute('href');

	// A, DIV, BUTTON
	var elemType = target.nodeName; // => A
	if( elemType != "A")
	{
		return;
	}
	window.location = href;

	return false;
}
	
function getSearchResults(string) {
	return new Promise(function(resolve,reject)
	{
		StoreSearch.GetQueryResults(string,function(result, event){

		if (event.status)
		{
			resolve(result);
		}
		else
		{
			reject(result,event);
		}
		},
		{escape: true});
	});
}
	
function clearResults()
{
	document.getElementById(INPUT_CONTAINER).value=""
	document.getElementById(RESULTS_CONTAINER).innerText="";
}