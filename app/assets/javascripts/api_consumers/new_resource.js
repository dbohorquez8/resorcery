var NewResourceForm = (function(){
  'use strict';
  var $form, $name, $submit, $resourceList;

  function init(formSelector, listSelector){
    $form = $(formSelector);
    $name = $form.find('.js-name');
    $submit = $form.find('.js-submit');

    $resourceList = $(listSelector);

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
      resource: {
        name: $name.val()
      }
    };
    return params;
  }

  function successCallback(data){
    var template = ich['js-resources-list-item-template'];
    $resourceList.append(template(data.response));
  }

  function failureCallback(something){
    console.log('Form submit failed', something);
  }

  return {
    init: init
  };
})();
