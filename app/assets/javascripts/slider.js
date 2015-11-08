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

  function getRangeFromHash(){
    var from, to, parsedHash = HashParser.getParsedHash(), range = {};
    if (parsedHash.start_date && (from = values.indexOf(parsedHash.start_date)) != -1) {
      range.from = from;
    }

    if (parsedHash.end_date && (to = values.indexOf(parsedHash.end_date)) != -1) {
      range.to = to;
    }
    return range;
  }

  function init(selector, defaultRange, defaultValues) {
    values = defaultValues;
    var initialRange = _.merge({}, defaultRange, getRangeFromHash());

    setRangeValues(initialRange);

    $elem = $(selector);
    return $elem.ionRangeSlider({
        grid: true,
        drag_interval: true,
        type: "double",
        from: initialRange.from,
        to: initialRange.to,
        values: values,
        onStart: handleUpdate,
        onFinish: handleUpdate
    });
  }

  return {
    init: init
  };
})();
