// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require underscore
//= require gmaps/google
//= require highcharts
//= require turbolinks
//= require_tree .

Turbolinks.enableProgressBar();
Turbolinks.pagesCached(20);
Turbolinks.enableTransitionCache();

function pushAlert(message) {
  var message_box = '<div class="alert fade in alert-success "> <button class="close" data-dismiss="alert">×</button>' + message + '</div>'
  $(".alert").alert('close');
  $('#bootstrap_flash').prepend(message_box);
}
