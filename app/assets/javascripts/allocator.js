Allocator = (function(){
  var popup, popupTemplate;

  function init(linkSelector, template) {
    popup = new $.Popup();
    popupTemplate = template;
    bindEvents(linkSelector);
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
    NewAllocationForm.init('.js-new-allocation-form');
  }

  return {
    init: init,
    start: start
  };
})();
