$(function (){
  function getURL() {
    var baseURL = Resorcery.routes.workspacePath.replace(/:wid/, Resorcery.workspaceId), queryTerms = [];
    var queryString = $.param(Resorcery.getDateParams());

    if (queryString.length){
      baseURL = baseURL + "?" + queryString;
    }
    return baseURL;
  }

  Resorcery.getDateParams = function() {
    var params = {}
    if (Resorcery.startDate) {
      params.start_date = Resorcery.startDate.toISOString();
    }
    if(Resorcery.endDate) {
      params.end_date = Resorcery.endDate.toISOString();
    }
    return params;
  }

  Resorcery.refresh = function () {
    $.getJSON(getURL(), function (workspaceJSON) {
      Resorcery.workspace = Resorcery.parser(workspaceJSON);
      Resorcery.render();
    });
  }
});
