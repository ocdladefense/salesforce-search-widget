var NO_SEARCH_RESULT_STRING = "No Data Yet!";
var WIDGET_CONTAINER = "search-widget";
var RESULTS_CONTAINER = "search-results";
var INPUT_CONTAINER = "searchInputBox";
var LOADER_CONTAINER = "loader-icon-container";
var SEARCH_STATUS = "search-status";
// Change values


var CUSTOM_RESULT_RENDERER = function(res) {
	console.log(res);
	var prodName = res.Name;
	var prodId = res.Id;
	var prodFamily = res.Family;
	var prodHtml="<a href='/"+prodId+"' class='family-" + prodFamily + "'>"+ prodName + " - <strong>" + prodFamily + "</strong></a><br />";
	

	return prodHtml;
};

function renderSearchLabel(){
	var searchResultLabel = document.getElementById(RESULT_CONTAINER);

	searchResultLabel.innerHTML = NO_SEARCH_RESULT_STRING;
}

function renderLoader(){
	var loaderElement = document.getElementById(LOADER_CONTAINER);

	loaderElement.classList.add("loader");
}

{/* <i class="fas fa-download"></i> */}