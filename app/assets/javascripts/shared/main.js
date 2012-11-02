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
	});
});
