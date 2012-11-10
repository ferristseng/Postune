$(function() {
	createVolumeSlider();

	function changeVolumeSlider(volume) {
		Player.user.volume = volume;
		if(Player.user.volume == 0) {
			$("#volume-icon").attr('class', 'icon-volume-off');
		} else if(volume < 50) {
			$("#volume-icon").attr('class', 'icon-volume-down');
		} else {
			$("#volume-icon").attr('class', 'icon-volume-up');
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