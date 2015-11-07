// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require lodash
//= require jquery_ujs
//= require d3
//= require parser
//= require circle-packing

// js for api wrappers and consumers

//= require notify
//= require api_wrapper/base
//= require api_wrapper/easy_form

//= require api_consumers/new_resource_group

//= require workspaces

'use-strict';

Resorcery = {
  utils: {},
  routes: {
    workspacePath: '/1/w/:wid'
  }
};
