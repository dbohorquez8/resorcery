$(function (){
  // $.getJSON(Resorcery.routes.workspacePath.replace(/:wid/, Resorcery.workspace_id), function (workspaceJSON) {

  //   Resorcery.workspace = workspaceJSON.response;

    $('.js-toggle-sidebar').on('click', function(){
      var target = $(this).data('target');
      $(target).toggleClass('is-visible');
      $(this).toggleClass('is-active');
    });

  //   setup_workspace(Resorcery.workspace);
  // });

  // function setup_workspace(workspace) {
    Resorcery.render();
  // }

  $(document).on('ajax:success', '#new_workspace', function (e, data, status, xhr) {
    window.location = data.response.location;
  });

});



