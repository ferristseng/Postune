$(function() {
	$(document).on("submit", "#search-form form", function() {
		loadingGif("#search-results");
	});

	$(document).on("submit", ".new-song", function() {
		ajaxCallback("#" + $(this).parent().attr("id"), 0);
	});

	// 0 = loading, 1 = success, -1 = error
	function ajaxCallback(div, status) {
		var callbackDiv = $("<div class='callback'>" + status + "</div>");
		callbackDiv.css({
			width: $(div).width(),
			height: $(div).height()
		});
		callbackDiv.prependTo(div);
	}
});