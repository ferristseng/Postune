// btn-extend
// data-toggle
// trigger dropdown
$(function() {
  $("[data-toggle='dropdown']").on("click", function(e) {
    e.preventDefault();

    $(this).toggleClass("open");
    $(this).parent().find(".dropdown-menu").toggle();

    $(":not([data-toggle='dropdown'])").on("click", function(e) {
      $("[data-toggle='dropdown']").removeClass("open");
      $(this).parent().find(".dropdown-menu").hide();
    });

    e.stopPropagation();
  });
});

// data-toggle
// trigger modal
$(function() {
  // close modal
  function closeModal() {
    $('body').removeClass('modal-open');
    $('.modal').removeClass('in');
    $('.modal-backdrop').removeClass('in');
    setTimeout(function() { $('.modal-backdrop').remove() }, 150);
  }

  $("[data-toggle='modal']").on("click", function(e) {
    e.preventDefault();

    var modalId = $(this).attr('href');

    $('body').toggleClass('modal-open');

    if($(this).attr("data-target") != "") {
      $(modalId).find('.modal-body').load($(this).attr("data-target"));
    }

    $("<div class='modal-backdrop fade' />")
      .appendTo('body');

    $(modalId)
      .show()
      .toggleClass('in');

    $(".modal-backdrop").toggleClass("in");
  });

  $("[data-dismiss='modal']").on("click", function(e) {
    e.preventDefault();
    closeModal();
  });

  
});