var Player = new function() {

 	this.soundManagerInstance;
 	this.user = {
 		volume: 60
 	};
 	this.playing;

	soundManager.url = '/swf/';
	soundManager.flashVersion = 9;
	soundManager.useFlashBlock = false;
	soundManager.useHighPerformance = true;
	soundManager.wmode = 'transparent';
	soundManager.flashPollingInterval = 500;
	soundManager.html5PollingInterval = 500;
	soundManager.useFastPolling = true;
	soundManager.useHTML5Audio = true;
	soundManager.preferFlash = false;
	soundManager.debugMode = true;

	this.load = function(data) {
		this.playing = data;
		if(soundManager.getSoundById("track") != undefined) {
			soundManager.destroySound("track");
		}
		soundManager.onready(function() {
			Player.soundManagerInstance = soundManager.createSound({
				id: "track",
				url: Player.playing.song.path,
				autoPlay: false,
				autoLoad: false,
				whileplaying: function() {
				},
				onfinish: function() {
				},
				onplay: function() {
					Player.volume(Player.user.volume);
				},
				ondataerror: function() {
					newMessage("error", "An error occured loading the song.");
				},
				onerror: function(error) {
					newMessage("error", "An error occured loading the song.");
				}
			});
		})
	}

	this.unload = function() {
		soundManager.unload("track");
	}

	this.playOffset = function(time) {
		var time = time;
		soundManager.onready(function() {
			soundManager.load('track', {
				onload: function() {
					if(time > Player.soundManagerInstance.durationEstimate) {
						console.log(time + " " + Player.soundManagerInstance.durationEstimate);
						console.log("Unloading...");
						Player.unload();
					} else {
						Player.seek(time);
						Player.play();
					}
				}
			});
		});
	}

	this.play = function() {
		this.soundManagerInstance.play();
	}

	this.stop = function() {
		this.soundManagerInstance.stopAll();
	}

	this.pause = function() {
		this.soundManagerInstance.pauseAll();
	}

	this.resume = function() {
		this.soundManagerInstance.resumeAll();
	}

	this.volume = function(volume) {
		soundManager.setVolume("track", volume);
	}

	this.seek = function(duration) {
		this.soundManagerInstance.setPosition(duration);
	}
}