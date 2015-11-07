$(function (){
  $('.js-toggle-sidebar').on('click', function(){
    var $target = $($(this).data('target'));
    $target.toggleClass('is-visible');
    $(this).toggleClass('is-active');

    // so we always focus the first imput toggled with this
    setTimeout(function(){
      if($target.hasClass("is-visible")){
        $target.find("input[type=text]:first").focus();
      }
    }, 300);

  });

  Resorcery.render();

  $(document).on('ajax:success', '#new_workspace', function (e, data, status, xhr) {
    window.location = data.response.location;
  });

});



