/**
 * Event handling *only for the Search Widget
 */

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