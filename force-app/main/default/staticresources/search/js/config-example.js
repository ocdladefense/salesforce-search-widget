var NO_SEARCH_RESULT_STRING = "No Data Yet!";
var WIDGET_CONTAINER = "searchWidget";
var RESULTS_CONTAINER = "outputLabel";
var INPUT_CONTAINER = "searchInputBox";



var CUSTOM_RESULT_RENDERER = function(res) {
	var prodName = res.Name;
	var prodId = res.Id;
	var prodHtml="<a href='/"+prodId+"'>"+ prodName + "</a><br />";
	
	return prodHtml;
};