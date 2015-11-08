var NewResourceGroupForm = (function(){
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
      }
    });
  }

  function formData(){
    var params = {
      resource_group: {
        name: $name.val()
      }
    };
    return params;
  }

  // define handlers for submit button.
  function successCallback(something){
    Resorcery.refresh();
  }

  function failureCallback(something){
    console.log('Form submit failed', something);
  }

  return {
    init: init
  };
})();
