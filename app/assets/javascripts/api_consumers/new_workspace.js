var NewWorkspaceForm = (function(){
  'use strict';
  var $form, $name, $submit;

  function init(formSelector){
    $form = $(formSelector);
    $name = $form.find('.js-name');
    $submit = $form.find('.js-submit');

    (new EasyForm).listen($form, {
      successCallback: successCallback,
      failureCallback: failureCallback,
      data:            formData
    });

    $form.on("submit-finished", function(evt, status, data){
      if(status == "success"){
        // clean the form
        $name.val("");
        // append the new workspace to the page
        var newWorkspace = $(ich["js-workspace-template"](data.response));
        $(".js-new-workspace-container").after(newWorkspace);
      }
    });
  }

  function formData(){
    var params = {
      workspace: {
        name: $name.val()
      }
    };
    return params;
  }

  // define handlers for submit button.
  function successCallback(something){
  }

  function failureCallback(something){
    console.log('Form submit failed', something);
  }

  return {
    init: init
  };
})();
