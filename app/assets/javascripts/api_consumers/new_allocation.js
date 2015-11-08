var NewAllocationForm = (function(){
  'use strict';
  var $form, $resourceId, $resourceGroupId, $startDate, $endDate, $submit;

  function init(formSelector){
    $form = $(formSelector);
    $resourceId = $form.find('.js-resource-id');
    $resourceGroupId = $form.find('.js-resource-group-id');
    $startDate = $form.find('.js-start-date');
    $endDate = $form.find('.js-end-date');
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
      allocation: {
        resource_id: $resourceId.val(),
        resource_group_id: $resourceGroupId.val(),
        start_date: $startDate.val(),
        end_date: $endDate.val()
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
