// btn-extend
// data-toggle
// trigger dropdown
$(function() {
  $("[data-toggle='dropdown']").on("click", function(event) {
    event.preventDefault();

    $(this).toggleClass("open");
    $(this).parent().find(".dropdown-menu").toggle();

    $(":not([data-toggle='dropdown'])").on("click", function(event) {
      $("[data-toggle='dropdown']").removeClass("open");
      $(this).parent().find(".dropdown-menu").hide();
    });

    event.stopPropagation();
  });
});