var EasyForm = (function(){
  "use strict";
  var $form, $formObject, $successCallback, $failureCallback, $data;

  function listen(form, options){
    $form            = form;
    $formObject      = FormObject.init($form);
    $successCallback = options.successCallback || function(){};
    $failureCallback = options.failureCallback || function(){};
    $data            = options.data;
    submitButtonHandler();
  }

  function disableFormAndPage(){
    $form.find("input[type=submit]").attr("disabled", true);
    $form.parents("body").find("div.overlay").show();
  }

  function enableFormAndPage(){
    $form.find("input[type=submit]").attr("disabled", false).removeAttr("disabled");
    $form.parents("body").find("div.overlay").hide();
  }

  function success(data, textStatus, jqXHR){
    $successCallback(data);
    $form.trigger("submit-finished", ["success", data]);
  }

  function failure(data, textStatus, jqXHR){
    console.log(data, textStatus, jqXHR);
    $failureCallback(data);
    addErrorsToElements(data);
    $form.trigger("submit-finished", ["error", data]);
  }

  function addErrorsToElements(data){
    var errors = data.error.messages;
    if(typeof errors == "undefined") return true;
    $.each( Object.keys(errors) , function(i, elem){
      $formObject.find("[data-name=" + elem + "]").addClass("errored");
    });
  }

  function submitButtonHandler(){
    $form.on('submit', function(evt){
      disableFormAndPage();
      evt.preventDefault();
      evt.stopPropagation();
      // get the form data, calling the function that its supposed to return it.
      var formData = $data($formObject);

      API.post({
        url:             $form.attr('action'),
        data:            formData,
        headers:         { },
        successCallback: success,
        failureCallback: failure,
        complete:        function(){
          enableFormAndPage();
          console.log("complete API post");
        }
      });
    });

    $form.on("submit-finished", function(evt, status, data){
      console.log("finished submitting the form")
    });
  }

  return {
    listen: listen
  };
})();
