$(function() {
	var interval;

	$("html").on({
		"mouseenter": function() {
			var toggleBtn = $(this),
					dropdownInner = toggleBtn.find(".dropdown-inner");
			interval = setInterval(function() { dropdownInner.addClass("open"); }, 250);
		},
		"mouseleave": function() {
				var toggleBtn = $(this),
						dropdownInner = toggleBtn.find(".dropdown-inner");

				dropdownInner.removeClass("open");
				clearInterval(interval);
		},
	}, "[data-toggle='dropdown']");

	$("html").on("click", "[data-toggle='dropdown'] .dropdown-toggle", function() { event.preventDefault() });
});