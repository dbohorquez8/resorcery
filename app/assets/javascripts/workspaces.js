$(function (){
  $('.js-toggle-sidebar').on('click', function(){
    var target = $(this).data('target');
    $(target).toggleClass('is-visible');
    $(this).toggleClass('is-active');
  });
});