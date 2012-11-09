$(function() {
	createVolumeSlider();

	function changeVolumeSlider(volume) {
		Player.user.volume = volume;
		if(Player.user.volume == 0) {
			$("#volume-button-inner").css("background-position", "-200px 0px");
		} else if(volume < 50) {
			$("#volume-button-inner").css("background-position", "-250px 0px");
		} else {
			$("#volume-button-inner").css("background-position", "-300px 0px");
		}
		Player.volume(Player.user.volume);
	}

	function createVolumeSlider() {
		$("#volume-slider").slider({
			"min": 0,
			"max": 100,
			"orientation": "vertical",
			"value": Player.user.volume,
			"range": "max",
			"slide": function(event, ui) { changeVolumeSlider(ui.value) },
			"create": function(event, ui) { changeVolumeSlider(Player.user.volume) }
		});
	}
});