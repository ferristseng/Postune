$(function() {
	resizeAlbumThumb();

	$(window).on("resize", function() {
		resizeAlbumThumb();
	});

	function resizeAlbumThumb() {
		$(".album-thumb").height($(".album-thumb").width());
	}
});

var soundManagerInstance = new function() {

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
		soundManager.destroySound("sm_track");
		soundManagerInstance = soundManager.createSound({
			id: "sm_track",
			url: "http://p0.bcbits.com/download/track/713fbd050f17158c70bc342a708faf35/mp3-128/4018552788?c22209f7da1bd60ad42305b8eb189676dff146dbd8b8dc5f7318ce15c4b35d9c6474e108e23c36d81151b58a3fcf70712a87edb96b12d3b9605f5d91a2b8a318877b4d106b684f1f9193e832a7ce64ac0e97ed1a5275e9f898f993cc8bd01da39596a72b6fbca817a5211f6dd9d78c936a0344&fsig=4bdbe5e67c5cecde1961c1913a31ba22&id=4018552788&stream=1&ts=1350360000.0",
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
		soundManager.setVolume("sm_track", volume);
	}

	this.seek = function(pecent) {
		soundManager.setPosition("sm_track", percent * postunePlayer.playing.duration * 1000);
	}

	function assignDuration() {
	}
}