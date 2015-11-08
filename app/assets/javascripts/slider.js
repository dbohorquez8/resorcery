var DateRangeSlider = (function(){
  var $elem, values = [
    "Jan 2015", "Feb 2015", "Mar 2015",
    "Apr 2015", "May 2015", "Jun 2015",
    "Jul 2015", "Aug 2015", "Sept 2015",
    "Oct 2015", "Nov 2015", "Dec 2015",
    "Jan 2016", "Feb 2016", "Mar 2016",
    "Apr 2016", "May 2016", "Jun 2016",
    "Jul 2016", "Aug 2016", "Sept 2016",
    "Oct 2016", "Nov 2016", "Dec 2016"
  ];

  function setRangeValues (range) {
    Resorcery.startDate = values[range.from];
    Resorcery.endDate   = values[range.to];
  }

  function handleUpdate (data) {
    setRangeValues({from: data.from, to: data.to});
    Resorcery.refresh();
  }

  function init(selector, range) {
    setRangeValues(range);
    $elem = $(selector);
    $elem.ionRangeSlider({
        grid: true,
        drag_interval: true,
        type: "double",
        from: range.from,
        to: range.to,
        values: values,
        onStart: handleUpdate,
        onFinish: handleUpdate
    });
  }

  return {
    init: init
  };
})();
