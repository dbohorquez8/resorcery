var DateRangeSlider = (function(){
  var $elem, values;

  function setRangeValues (range) {
    setDateField('startDate', values[range.from]);
    setDateField('endDate', values[range.to]);
  }

  function setDateField (fieldName, value) {
    delete Resorcery[fieldName];
    Resorcery[fieldName] = moment(value);
  }

  function handleUpdate (data) {
    setRangeValues({from: data.from, to: data.to});
    Resorcery.refresh();
  }

  function init(selector, range, defaultValues) {
    values = defaultValues;

    setRangeValues(range);
    $elem = $(selector);
    return $elem.ionRangeSlider({
        grid: true,
        drag_interval: true,
        max_interval: 7,
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
