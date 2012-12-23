$(function() {
	$("body").on("click", "[data-toggle='tab']", function(e) {
		e.preventDefault();
		/*
		 * Assume structure
		 * 	wrapper (div / section / etc.)
		 *		ulParent (div / section / etc.)
		 *			liParent (ul)
		 *				aParent (li)
		 *		frames
		 */
		var aParent = $(this).parent(),
				liParent = aParent.parent(),
				ulParent = liParent.parent(),
				wrapper = ulParent.parent(),
				toggledFrame = $(this).attr("href");

		wrapper.find(".tab-frame.open").removeClass("open");

		// toggle the currently open li class
		liParent.find(".open").removeClass("open");

		// set the the new li class to open
		aParent.addClass("open");

		// open the tab-frame
		wrapper.find(toggledFrame).addClass("open");

		// TEMPORARY REMOVE LATER
		if($("#chat-text").length > 0) {
			$("#chat-text").scrollTop($("#chat-text")[0].scrollHeight);
		}
	});
});

function newMessage(content, type) {
	$(".message.float").remove();
	$("<div class='message top " + type + "'>" + content + "</div>").prependTo("body");
}

function loadingGif(parent) {
	$(parent).html("<div class='center text loading-gif'><img src='/assets/load.gif' /></div>");
}