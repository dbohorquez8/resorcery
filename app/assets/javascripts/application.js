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
//= require moment
//= require lodash
//= require jquery_ujs
//= require d3
//= require masonry
//= require icanhaz
//= require ion.rangeSlider
//= require slider
//= require popup
//= require pikaday

//= require hash_parser
//= require parser
//= require renderer
//= require refresher
//= require notify
//= require allocator

// js for api wrappers and consumers

//= require api_wrapper/base
//= require api_wrapper/easy_form

//= require api_consumers/new_resource_group
//= require api_consumers/new_resource
//= require api_consumers/new_workspace
//= require api_consumers/new_allocation


//= require workspaces

'use-strict';

Resorcery = {
  utils: {},
  routes: {
    workspacePath: '/1/w/:wid'
  }
};
