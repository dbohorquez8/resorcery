$(function (){
  function getURL() {
    var parsedDate, baseURL = Resorcery.routes.workspacePath.replace(/:wid/, Resorcery.workspaceId), queryTerms = [];

    if (Resorcery.startDate) {
      parsedDate = new Date (Resorcery.startDate);
      queryTerms.push("start_date="+parsedDate.toISOString());
    }

    if (Resorcery.endDate) {
      parsedDate = new Date (Resorcery.endDate);
      queryTerms.push("end_date="+parsedDate.toISOString());
    }

    if (queryTerms.length) {
      baseURL = baseURL + "?" + queryTerms.join('&');
    }

    return baseURL;
  }

  Resorcery.refresh = function () {
    $.getJSON(getURL(), function (workspaceJSON) {
      Resorcery.workspace = Resorcery.parser(workspaceJSON);
      Resorcery.render();
    });
  }
});
