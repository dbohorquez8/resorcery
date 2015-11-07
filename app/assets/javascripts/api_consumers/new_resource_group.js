var NewMessageForm = (function(){
  'use strict';
  var $form, $select, $recurring, $message,
  $sun, $mon, $tue, $wed, $thu, $fri, $sat,
  $customDate, $customTime;

  function init(formSelector){
    $form = $(formSelector);
    $select = $form.find('.js-when');
    $message = $form.find('.js-message');
    $customDate = $form.find('.js-custom-date');
    $customTime = $form.find('.js-custom-time');
    $recurring = $form.find('.js-recurring');
    $sun = $form.find('.js-recurring-sun');
    $mon = $form.find('.js-recurring-mon');
    $tue = $form.find('.js-recurring-tue');
    $wed = $form.find('.js-recurring-wed');
    $thu = $form.find('.js-recurring-thu');
    $fri = $form.find('.js-recurring-fri');
    $sat = $form.find('.js-recurring-sat');

    initFormBehaviour();
    MessagesDatePicker.init($form);

    AP.register({
      'dialog-button-click': buttonClicked
    });

    EasyForm.listen($form, {
      formLabel:       'Schedule Message',
      successCallback: successCallback,
      failureCallback: failureCallback,
      data:            formData
    });
  }

  function initFormBehaviour(){
    $select.on('change', function(evt){
      //depending on the selected value, we will show or hide elements of the form.
      switch($(evt.target).val()){
        case 'custom_date':
          showCustomDate();
        break;
        case 'recurring':
          showRecurring();
        break;
        default:
          hideRecurring();
          hideCustomDate();
        break;
      }
    });
  }

  // erases all the data asociated with custom date fields
  function cleanCustomDate(){
    $recurring.val('false');
    $customTime.val('');
    $customDate.val('');
  }

  // erases all the data asociated with recurring fields
  function cleanRecurring(){
    $recurring.val('false');
    $sun.val('0');
    $mon.val('0');
    $tue.val('0');
    $wed.val('0');
    $thu.val('0');
    $fri.val('0');
    $sat.val('0');
    $form.find('.js-start-day').val('');
    $form.find('.js-end-day').val('');
  }

  function setRecurrentDays(){
    $sun.val(+$('#recurring-sun').is(':checked'));
    $mon.val(+$('#recurring-mon').is(':checked'));
    $tue.val(+$('#recurring-tue').is(':checked'));
    $wed.val(+$('#recurring-wed').is(':checked'));
    $thu.val(+$('#recurring-thu').is(':checked'));
    $fri.val(+$('#recurring-fri').is(':checked'));
    $sat.val(+$('#recurring-sat').is(':checked'));
  }

  // this is the function that takes the form data. It receives a FormObject
  function setHumanScheduleTime() {
    var human_schedule_time;
    switch($select.val()){
      case 'custom_date':
        human_schedule_time = $customDate.val() + ' ' + $customTime.val();
      break;
      case 'recurring':
        human_schedule_time = 'false';
      break;
      default:
        human_schedule_time = $select.val();
      break;
    }
    $form.find(".js-human_schedule_time").val(human_schedule_time);
  }

  // hides the recurring fields
  function hideRecurring(){
    cleanRecurring();
    $form.find('.js-recurring-date-form-container').hide();
  }

  //hides all attributes and shows only recurring fields
  function showRecurring(){
    hideCustomDate();
    $recurring.val('true');
    $form.find('.js-recurring-date-form-container').show();
  }

  //shows only the start date and time.
  function showCustomDate(){
    hideRecurring();
    $form.find('.js-custom-date-form-container').show();
  }

  function hideCustomDate(){
    cleanCustomDate();
    $form.find('.js-custom-date-form-container').hide();
  }

  function formData(){
    // use .js-custom-time and .js-custom-date as building blocks, format: September 22, 2015 12:00 am
    // var human_schedule_time = form.getVal(".js-custom-date") + " " + form.getVal(".js-custom-time");
    var params = {
      data: {
        message: {
          recurring:            $recurring.val(),
          recipient:            roomId,
          recipient_display:    'slater',
          message:              $message.val(),
          human_schedule_time:  $form.find('.js-human_schedule_time').val(),
          recurring_start_date: $form.find('.js-start-day').val(),
          recurring_end_date:   $form.find('.js-end-day').val(),
          recurring_days:       {
            Sun: $sun.val(),
            Mon: $mon.val(),
            Tue: $tue.val(),
            Wed: $wed.val(),
            Thu: $thu.val(),
            Fri: $fri.val(),
            Sat: $sat.val()
          },
          recurring_time: $form.find('.js-recurring-time').val()
        }
      }
    };
    return params;
  }

  // define handlers for submit button.
  function successCallback(something){
    // BEGINING - update scheduled messages glance
    API.post({
      url:             '/update/scheduled_messages',
      data:            {},
      headers:         { 'x-acpt': signedRequest },
      successCallback: function(something){
        console.log(something);
      },
      failureCallback: function(something){
        console.log(something);
      }
    });
    setTimeout(function(){
      AP.require('sidebar', function(sidebar) {
        sidebar.openView({
          key: 'scheduled.messages.glance'
        });
      });
    }, 400);
    // END - update scheduled messages glance
    console.log('Form submit succeded');
  }

  function failureCallback(something){
    console.log('Form submit failed', something);
  }

  function buttonClicked(event, closeDialog) {
    if (event.action === 'submit.schedule.message') {
      AP.require('sidebar', function(sidebar) {
        sidebar.closeView({
          key: 'scheduled.messages.glance'
        });
      });
      setHumanScheduleTime();
      setRecurrentDays();
      $form.data('closeDialog', closeDialog);
      $form.trigger('submit');
    }
  }

  return {
    init: init
  };
})();
