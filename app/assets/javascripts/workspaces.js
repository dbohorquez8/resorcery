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

  DateRangeSlider.init("#js-workspace-date-slider", {from: 3, to: 7});
  Resorcery.refresh();

  $(document).on('ajax:success', '#new_workspace', function (e, data, status, xhr) {
    window.location = data.response.location;
  });

});



