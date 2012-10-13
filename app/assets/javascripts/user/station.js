$(function() {
	resizeAlbumThumb();

	$(window).on("resize", function() {
		resizeAlbumThumb();
	});

	function resizeAlbumThumb() {
		$(".album-thumb").height($(".album-thumb").width());
	}
});