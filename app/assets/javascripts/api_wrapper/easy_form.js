function EasyForm() {
  "use strict";
  var $form, $successCallback, $failureCallback, $data;

  function listen(form, options){
    $form            = form;
    $successCallback = options.successCallback || function(){};
    $failureCallback = options.failureCallback || function(){};
    $data            = options.data;
    submitButtonHandler();
  }

  function disableFormAndPage(){
    $form.find("input[type=submit]").attr("disabled", true);
    $form.parents("body").find(".js-overlay").fadeIn();
  }

  function enableFormAndPage(){
    $form.find("input[type=submit]").attr("disabled", false).removeAttr("disabled");
    $form.parents("body").find(".js-overlay").hide();
  }

  function success(data, textStatus, jqXHR){
    $successCallback(data);
    $form.trigger("submit-finished", ["success", data]);
    $.notify(data.server_message, "success", { globalPosition:"bottom center" });
  }

  function failure(data, textStatus, jqXHR){
    console.log(data, textStatus, jqXHR);
    $failureCallback(data);
    addErrorsToElements(data);
    $form.trigger("submit-finished", ["error", data]);
    $.notify(data.server_message, "error", { globalPosition:"bottom center" });
  }

  function addErrorsToElements(data){
    var errors = data.response.messages;
    if(typeof errors == "undefined") return true;
    $.each( Object.keys(errors) , function(i, elem){
      $form.find("[data-name=" + elem + "]").addClass("errored");
    });
  }

  function submitButtonHandler(){
    $form.on('submit', function(evt){
      disableFormAndPage();
      evt.preventDefault();
      evt.stopPropagation();
      // get the form data, calling the function that its supposed to return it.
      var formData = $data();

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

    // $form.on("submit-finished", function(evt, status, data){
    //   console.log("finished submitting the form")
    // });
  }

  this.listen = listen;
};
