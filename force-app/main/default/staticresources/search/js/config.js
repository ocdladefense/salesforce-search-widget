 var NO_SEARCH_RESULT_STRING = "No Data Yet!";
 var WIDGET_CONTAINER = "searchWidget";
 var RESULTS_CONTAINER = "outputLabel";
 var INPUT_CONTAINER = "searchInputBox";


 
 
 var DEFAULT_RESULT_RENDERER = function(cResult)
 {
		var prodName = cResult.Name;
		var prodId = cResult.Id;
		var prodHtml="<a href='/"+prodId+"'>"+ prodName + "ID:"+prodId+"</a><br>";
		
		return prodHtml;
 };
 
 //uncomment if you want to render differently
 
 var CUSTOM_RESULT_RENDERER;
 /*
 var CUSTOM_RESULT_RENDERER= function(cResult)
 {
				 var prodName = cResult.Name;
		 var prodId = cResult.Id;
			 var prodHtml="<a href='/"+prodId+"'>"+ cResult.Description + </a><br>";
		 return prodHtml;
 };
 
 */