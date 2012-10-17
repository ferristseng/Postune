var Player = new function() {

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
		soundManager.destroySound("track");
		soundManagerInstance = soundManager.createSound({
			id: "track",
			url: url,
			autoPlay: true,
			whileplaying: function() {
			},
			onplay: function() {
			},
			onfinish: function() {
			},
			ondataerror: function() {
			},
			onerror: function(error) {
			}
		});
	}

	this.play = function() {
		soundManager.play();
	}

	this.stop = function() {
		soundManager.stopAll();
	}

	this.pause = function() {
		soundManager.pauseAll();
	}

	this.resume = function() {
		soundManager.resumeAll();
	}

	this.volume = function(volume) {
		soundManager.setVolume("track", volume);
	}

	this.seek = function(pecent) {
		soundManager.setPosition("track", percent * postunePlayer.playing.duration * 1000);
	}
}