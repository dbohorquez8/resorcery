var NewResourceGroupForm = (function(){
  'use strict';
  var $form, $name, $submit;

  function init(formSelector){
    $form = $(formSelector);
    $name = $form.find('.js-name');
    $submit = $form.find('.js-submit');

    EasyForm.listen($form, {
      successCallback: successCallback,
      failureCallback: failureCallback,
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

  function formData(formObject){
    var params = {
      resource_group: {
        name: formObject.getVal('.js-name')
      }
    };
    return params;
  }

  // define handlers for submit button.
  function successCallback(something){
    // BEGINING - update scheduled messages glance
    // API.post({
    //   url:             '/update/scheduled_messages',
    //   data:            {},
    //   headers:         { 'x-acpt': signedRequest },
    //   successCallback: function(something){
    //     console.log(something);
    //   },
    //   failureCallback: function(something){
    //     console.log(something);
    //   }
    // });
  }

  function failureCallback(something){
    console.log('Form submit failed', something);
  }

  return {
    init: init
  };
})();
