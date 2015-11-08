Allocator = (function(){
  var popup, popupTemplate;

  function init(linkSelector, template) {
    popup = new $.Popup();
    popupTemplate = template;
    bindEvents(linkSelector);
  }

  function parseDate(date){
    if(date == "anytime"){
      return moment().add(5, 'days');
    }else{
      return moment(date, "YYYY-MM-DD");
    }
  }

  function bindEvents(linkSelector) {
    $(document).on('click', linkSelector, function (evt){
      evt.preventDefault();
      evt.stopPropagation();
      evt.stopImmediatePropagation();

      var $target = $(this);
      var dateParams = Resorcery.getDateParams();

      Allocator.start({
        resourceId: $target.data('resource-id'),
        resourceName: $target.data('resource-name'),
        resourceGroups: Resorcery.workspace.children,
        startDate: dateParams.start_date,
        endDate: dateParams.end_date
      });
    });
  }

  function start(data) {
    var content = $("<div>");
    content.append(popupTemplate(data));
    popup.open(content);

    API.get({
      url: '/1/w/' + Resorcery.workspaceId + '/availabilities/' + data.resourceId + '?start_date='+ Resorcery.getDateParams().start_date,
      successCallback: function(something){
        $(".js-availability-list").html(ich['js-availability-list-template'](something));
      },
      failureCallback: function(something){
        console.log(something);
      }
    });

    var allocationForm = NewAllocationForm.init('.js-new-allocation-form');

    // when click on use this, it will modify dates in the date
    $(".js-availability-list").on('click', ".js-availability-use-this", function(){

      var startDate = $(this).data("start-date");
      var endDate = $(this).data("end-date");
      // if the endDate its anytime we will not add 3 days to the current date
      // but to the start_date
      if(endDate == "anytime"){
        endDate = moment($(this).data("start-date"), "YYYY-MM-DD").add(5, 'days')
      }

      NewAllocationForm.startDatePicker().setMoment( parseDate(startDate) );
      NewAllocationForm.endDatePicker().setMoment( parseDate(endDate) );
    });

    $('.js-new-allocation-form').on("submit-finished", function(evt, status, data){
      if(status == "success"){
        popup.close();
      }
    });

  }

  return {
    init: init,
    start: start
  };
})();
