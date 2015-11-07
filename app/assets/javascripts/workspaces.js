$(function (){
  $('.js-toggle-sidebar').on('click', function(){
    var target = $(this).data('target');
    $(target).toggleClass('is-visible');
    $(this).toggleClass('is-active');
  });

  $(document).on('ajax:success', '#new_workspace', function (e, data, status, xhr) {
    window.location = data.response.location;
  });
});
