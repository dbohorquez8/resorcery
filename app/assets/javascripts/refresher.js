$(function (){
  function getQueryString() {
    return $.param(Resorcery.getDateParams());
  }

  Resorcery.getDateParams = function() {
    var params = {}
    if (Resorcery.startDate) {
      params.start_date = Resorcery.startDate.format('YYYY-MM-DD');
    }
    if(Resorcery.endDate) {
      params.end_date = Resorcery.endDate.format('YYYY-MM-DD');
    }
    return params;
  }

  Resorcery.refresh = function () {
    var endpointURL = Resorcery.routes.workspacePath.replace(/:wid/, Resorcery.workspaceId);
    var queryString = getQueryString();

    if (queryString.length) {
      endpointURL = endpointURL + "?" + queryString;
    }

    $.getJSON(endpointURL, function (workspaceJSON) {
      if (queryString.length) {
        window.location.hash = queryString;
      }

      Resorcery.workspace = Resorcery.parser(workspaceJSON);
      Resorcery.render();
    });
  }
});
