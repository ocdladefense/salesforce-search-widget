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
    return !res.Family ? "fas fa-angle-right" :  getProductInfo()[res.Family][1];
}

/* <i class="fas fa-download"></i> */


function getProductInfo(){
    var groups = {
        "Publications":["DUII Trial Notebook","fas fa-book"],
        "Event Ticket":["2020 DUII Defense Member Lawyer","fa fa-ticket"],
        "Written Material Orders":["2020 DUII Defense - Written Materials","fas fa-book"],
        "CLE":["2009 Defending DUII Cases - CLE materials","fas fa-book"],
        "Raffles":["2020 Annual Conference - Hawaii Vacation Raffle","fa fa-ticket"],
        "Memberships":["Capital Defenders Memberships","fa fa-id-card"],
        "Donation":["Building Fund Donation","fas fa-hand-holding-usd"],
        "none":["Product w/o Family","fas fa-arrow-alt-circle-right"]
    };

    return groups;
}

function fetchSampleData(){
    var allSamples = [];
    var sample = {
				Id: "999",
				Name: "DUII Trial Notebook",
				Family: "Publications",
				Price: 350.00,
				Description: "lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut...",
				IsActive: true
		};

		
		var samples = getProductInfo();
		
    for(var fam in samples){
        var prod = JSON.parse(JSON.stringify(sample));
				var cp = samples[fam];
        prod.Family = fam;
        prod.Name = cp[0];
        allSamples.push(prod);
    }

    return allSamples;
}