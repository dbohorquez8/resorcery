/* add-on script */

var AjaxSettingsParser = (function(){
  "use strict";
  function defaultSettings(method){
    return {
      method: method || 'POST',
      dataType: 'json',
      cache: false,
      headers: {
        test: 'someheader'
      },
      data: {}
    };
  }

  function ajaxResponseHandler(successCallback, failureCallback){
    return {
      success: function(data, textStatus, jqXHR) {
        console.log("success");
        console.log(data);
        if (jqXHR.status == 204) {
          successCallback({ status: "ok" }, textStatus, jqXHR);
        }else if(data.response.error){
          failureCallback(data, textStatus, jqXHR);
        }else{
          successCallback(data, textStatus, jqXHR);
        }
      },
      error: function(xhr, status, err) {
        console.log("Something went wrong [AJAX]", status, err, xhr);
      }
    };
  }

  function generateParamsForAjax(method, settings){
    var options = $.extend(true, {}, defaultSettings(method), settings);
    // setup everything so we can have the callbacks called on time
    var onSuccessCallback = options.successCallback;
    delete options.successCallback;
    var onFailureCallback = options.failureCallback;
    delete options.failureCallback;
    return $.extend(true, {}, options, ajaxResponseHandler(onSuccessCallback, onFailureCallback));
  }
  return {
    generateParamsForAjax: generateParamsForAjax
  };
})();

var API = (function(){
  "use strict";
  function get(options){
    return request(AjaxSettingsParser.generateParamsForAjax('GET', options));
  }
  function put(){
    console.log("Uninplemented");
  }
  function post(options){
    return request(AjaxSettingsParser.generateParamsForAjax('POST', options));
  }
  function destroy(options){
    return request(AjaxSettingsParser.generateParamsForAjax('DELETE', options));
  }
  function request(settings){
    $.ajax(settings);
  }
  return {
    get: get,
    post: post,
    put: put,
    destroy: destroy
  };
})();

var FormObject = (function(){
  'use strict';
  var $form = null;

  var init = function(form){
    $form = form;
    return this;
  };

  function elem(_elem){
    return $form.find(_elem);
  }

  function getVal(_elem){
    return elem(_elem).val();
  }

  return {
    init: init,
    getVal: getVal,
    elem:   elem,
    find: elem
  };
})();
