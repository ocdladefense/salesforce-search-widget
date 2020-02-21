/**
 * Render the list of search results.
 *  
 *  A default render function is provided.
 * It prints the product name and id as a link.
 *  To customize this add a CUSTOM_RESULT_RENDERER function to your config.js
 */
function renderHtml(json) {
	var html = "";
	
	for(var sobjectname in json){
		for(var i = 0; i<json[sobjectname].length; i++) {
			var res = json[sobjectname][i];
			res.sobjectname = sobjectname;
			var prodHtml = !!CUSTOM_RESULT_RENDERER ? CUSTOM_RESULT_RENDERER(res) : default_renderer(res);
			
			html += prodHtml;
		}
	}
	
	
	return html;
}



/**
 * Default render function for search results.
 */
function default_renderer(res) {
		console.log(res);
		var prodName = res.Name;
		var prodId = res.Id;
		var prodHtml="<br><a href='/"+prodId+"'>"+ prodName + "ID:"+prodId+"</a>";
		
		return prodHtml;
 };



/**
 * A way to clear search results.
 */
function clearResults() {
	document.getElementById(INPUT_CONTAINER).value=""
	document.getElementById(RESULTS_CONTAINER).innerText="";
}