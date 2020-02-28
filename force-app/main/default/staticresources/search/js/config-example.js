var NO_SEARCH_RESULT_STRING = "No Data Yet!";
var WIDGET_CONTAINER = "search-widget";
var RESULTS_CONTAINER = "search-results";
var INPUT_CONTAINER = "searchInputBox";
var LOADER_CONTAINER = "loader-icon-container";
var SEARCH_STATUS = "search-status";
var USE_SAMPLE_DATA = true;

var CUSTOM_RESULT_RENDERER = function(res) {
	console.log(res);
	var prodName = res.Name;
	var prodId = res.Id;
	var prodFamily = res.Family;
    var prodHtml= 
    `<div class="product-result row py-3">
        <div class="col-1 text-center my-auto">
            <i class="${getIcon(res)} product-icon"></i>
        </div>
        <div class="col-8 pt-2 pl-0">
            <a href='#' class="product-name">${prodName}<span class="pl-2" ><i class="fas fa-info-circle"></i></span></a>
            <p class="product-description">${res.Description}</p>
        </div>   
        <div class="col-3 text-right my-auto pt-2">
            <p class="product-family mb-0">${prodFamily}</p>
            <p class="product-price">$${res.Price.toFixed(2)}</p>
        </div>
    </div>`;
    

    // /*
    // "<i class='"+getIcon(res)+"'</i><a href='/"+prodId+"' class='family-" + prodFamily + "'>"
    // + prodName + " - <strong>" + prodFamily + "</strong></a><br />";
	// */

	return prodHtml;
};

function noSearchResults(){
	return NO_SEARCH_RESULT_STRING;
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
    return getFamilies()[res.Family];

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


function getFamilies(){
    var families = {
        "Publications":"fas fa-book",
        "Event Ticket":"fa fa-ticket",
        "Written Material Orders":"fas fa-book",
        "CLE":"fas fa-book",
        "Raffles":"fa fa-ticket",
        "Capital Defenders Memberships":"fa fa-id-card",
        "Donation":"fas fa-hand-holding-usd",
        "Donation Fund":"fas fa-hand-holding-usd",
        "none":"fas fa-arrow-alt-circle-right",
    };

    return families;
}

function fetchSampleData(){
    var allSamples = [];
    var sample =
        {
            Id: "999",
            Name: "DUII Trial Notebook",
            Family: "Publications",
            Price: 350.00,
            Description: "lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut...",
            IsActive: true
        }
    var families = getFamilies()

    for(var family in getFamilies()){
        var prod = JSON.parse(JSON.stringify(sample));

        prod.Family = family;
        allSamples.push(prod);
    }

    return allSamples;
}