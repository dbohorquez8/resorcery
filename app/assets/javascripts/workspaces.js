$(function (){

  $('.js-toggle-sidebar').on('click', function(){
    var $target = $($(this).data('target'));
    $target.toggleClass('is-visible');
    $(this).toggleClass('is-active');

    setTimeout(function(){
      if($target.hasClass("is-visible")){
        $target.find(".js-group-input-name").focus();
      }
    }, 300);

  });

  // Note that 11 and 18 are *NOT* arbitrary, this makes sure we select a range around today
  Resorcery.DateRangeSlider = (DateRangeSlider.init("#js-workspace-date-slider", {from: 11, to: 18}, Resorcery.defaultDates)).data('ionRangeSlider');
  Resorcery.refresh();

  Allocator.init('.js-open-allocate-form', ich['js-new-allocation-form-template']);

  $(document).on('ajax:success', '#new_workspace', function (e, data, status, xhr) {
    window.location = data.response.location;
  });

});



