var Player = new function() {

 	this.soundManagerInstance;
 	this.user = {
 		volume: 60
 	};

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

	this.load = function(url) {
		soundManager.onready(function() {
			Player.soundManagerInstance = soundManager.createSound({
				id: "track",
				url: url,
				autoPlay: false,
				whileplaying: function() {
				},
				onfinish: function() {
					soundManager.destroySound("track");
				},
				ondataerror: function() {
				},
				onerror: function(error) {
				}
			});
		})
	}

	this.playOffset = function(time) {
		var time = time;
		soundManager.onready(function() {
			soundManager.play('track', {
				onload: function() {
					Player.seek(time);
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
		soundManager.setPosition("track", duration);
	}
}