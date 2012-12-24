$(function() {
	$(document).on("submit", "#search-form form", function() {
		loadingGif("#search-results");
	});

	$(document).on("submit", ".new-song", function() {
		ajaxCallback("#" + $(this).parent().attr("id"), 0);
	});
});

// 0 = loading, 1 = success, -1 = error
function ajaxCallback(div, status) {
	var callbackDiv, statusDiv;
	switch(status) {
		case -1:
			statusDiv = "<div class='callback-status'><div class='icon error'></div><div class='status-message'>An Error Occured: Please Try Playing Another Song</div></div>";
			break;
		case 0:
			statusDiv = "<div class='callback-status'><div class='icon loading'></div></div>";
			break;
		case 1:
			statusDiv = "<div class='callback-status'><div class='icon success'></div></div>"
	}
	$(div + " .callback").remove();
	callbackDiv = $("<div class='callback'>" + statusDiv + "</div>");
	callbackDiv.css({
		width: $(div).width(),
		height: $(div).height()
	});
	callbackDiv.prependTo(div);
}