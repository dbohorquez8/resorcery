var NewAllocationForm = (function(){
  'use strict';
  var $form, $resourceId, $resourceGroupId, $startDate, $endDate, $submit;

  function init(formSelector){
    $form = $(formSelector);
    $resourceId = $form.find('.js-resource-id');
    $resourceGroupId = $form.find('.js-resource-group-id');

    $startDate = new Pikaday({ field: $form.find('.js-start-date')[0] });
    $endDate = new Pikaday({ field: $form.find('.js-end-date')[0] });

    $submit = $form.find('.js-submit');

    (new EasyForm).listen($form, {
      successCallback: successCallback,
      failureCallback: failureCallback,
      data:            formData
    });
  }

  function formData(){
    var params = {
      allocation: {
        resource_id: $resourceId.val(),
        resource_group_id: $resourceGroupId.val(),
        start_date: $startDate.getDate(),
        end_date: $endDate.getDate()
      }
    };
    return params;
  }

  function successCallback(something){
    $startDate.destroy();
    $endDate.destroy();
    Resorcery.refresh();
  }

  function failureCallback(something){
    console.log('Form submit failed', something);
  }

  function startDatePicker(){
    return $startDate;
  }

  function endDatePicker(){
    return $endDate;
  }

  return {
    init: init,
    startDatePicker: startDatePicker,
    endDatePicker: endDatePicker,
  };
})();
