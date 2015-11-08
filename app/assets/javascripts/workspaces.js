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

  $.getJSON(Resorcery.routes.workspacePath.replace(/:wid/, Resorcery.workspaceId) + "?start_date=2015-09-01&end_date=2015-11-5", function (workspaceJSON) {
    Resorcery.workspace = Resorcery.parser(workspaceJSON);
    Resorcery.render();
  });

  $(document).on('ajax:success', '#new_workspace', function (e, data, status, xhr) {
    window.location = data.response.location;
  });

});



