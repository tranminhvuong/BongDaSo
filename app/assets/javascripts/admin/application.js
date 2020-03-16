//= require jquery
//= require bootstrap
//= require rails-ujs
//= require turbolinks
//= require_tree .

$(document).ready(function () {
  $('#sidebarCollapse').on('click', function () {
      $('#sidebar').toggleClass('active');
  });
});
