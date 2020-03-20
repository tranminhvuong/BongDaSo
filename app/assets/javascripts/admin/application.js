//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require trix


$(document).ready(function () {
    $('#sidebarCollapse').on('click', function () {
        $('#sidebar').toggleClass('active');
    });
});
