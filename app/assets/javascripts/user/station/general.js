$(function() {
	resizeAlbumThumb();

	$(window).on("resize", function() {
		resizeAlbumThumb();
	});

	$("body").on({
		mouseenter: function() {
			$(this).find(".play").show();
		},
		mouseleave: function() {
			$(this).find(".play").hide();
		}
	}, "#station-history .artwork");

	function resizeAlbumThumb() {
		$(".album-thumb").height($(".album-thumb").width());
	}
});