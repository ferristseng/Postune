$(function() {
	function resizeStationDivs() {
		$("#station-main .inner").outerHeight($("#inner").outerHeight() - 64);
		$("#station-main .inner .tabs.vertical").outerHeight($("#station-main .inner").outerHeight());
		$("#station-main .inner #chat-wrapper #chat-text").outerHeight($("#station-main .inner").outerHeight() - 68);
		$("#station-main .inner #search-song-form").outerHeight($("#station-main .inner").outerHeight() - 24);
	}

	resizeStationDivs();

	$(window).resize(function() {
		resizeStationDivs();
	});
});