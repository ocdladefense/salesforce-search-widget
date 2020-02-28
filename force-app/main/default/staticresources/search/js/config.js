var NO_SEARCH_RESULT_STRING = "No Data Yet!";
var WIDGET_CONTAINER = "search-widget";
var RESULTS_CONTAINER = "search-results";
var INPUT_CONTAINER = "searchInputBox";
var LOADER_CONTAINER = "loader-icon-container";
var SEARCH_STATUS = "search-status";


var CUSTOM_RESULT_RENDERER = function(res) {
	console.log(res);
	var prodName = res.Name;
	var prodId = res.Id;
	var prodFamily = res.Family;
	var prodHtml= "<i class='"+getIcon(res)+"'</i><a href='/"+prodId+"' class='family-" + prodFamily + "'>"+ prodName + " - <strong>" + prodFamily + "</strong></a><br />";
	

	return prodHtml;
};

function noSearchResults(){
	var searchResultLabel = document.getElementById(RESULT_CONTAINER);

	searchResultLabel.innerHTML = NO_SEARCH_RESULT_STRING;
}

function renderLoader(){
	var loaderElement = document.getElementById(LOADER_CONTAINER);

	loaderElement.classList.add("loader");
}

function removeLoader(){
	var loaderElement = document.getElementById(LOADER_CONTAINER);

	loaderElement.classList.remove("loader");
}

function getIcon(res){
	var family = "";

	switch(res.Family){
		case "Publications":
			family = "fas fa-book";
			break;
		case "Event Ticket":
			family = "fa fa-ticket";
			break;
		case "Written Material Orders":
			family = "fas fa-book";
			break;
		case "CLE":
			family = "fas fa-book";
			break;
		case "Raffles":
			family = "fa fa-ticket";
			break;
		case "Memberships":
			family = "fa fa-id-card";
			break;
		case "Capital Defenders Memberships":
			family = "fa fa-id-card";
			break;	
		case "Donation":
			family = "fas fa-hand-holding-usd";
			break;	
		case "Donation Fund":
			family = "fas fa-hand-holding-usd";
			break;	
		default:
			family = "fas fa-angle-right";
	}

	//iconHtml = "<i class='"+family+"'></i>";

	return family;
}

{/* <i class="fas fa-download"></i> */}