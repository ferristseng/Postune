$(function() {
	$(".info-button-toggle").on("click", function(event) {

		event.preventDefault();

		$(this).toggleClass("pressed");
		$("#controls").toggleClass("open");
		$("#song-info").toggleClass("hide");
	});
});

$(function() {
	$(".messages-wrapper").delay(1500).slideUp(400, function() { $(this).remove(); });
});