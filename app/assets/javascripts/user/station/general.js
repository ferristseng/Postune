$(function() {
	$(".info-button-toggle").on("click", function(event) {

		event.preventDefault();

		$(this).toggleClass("pressed");
		$("#controls").toggleClass("open");
		$("#song-info").toggleClass("hide");
	});
});