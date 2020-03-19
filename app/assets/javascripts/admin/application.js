//= require jquery
//= require bootstrap
//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets

$(document).ready(function () {
    $('#sidebarCollapse').on('click', function () {
        $('#sidebar').toggleClass('active');
    });
});
