$(function() {
    $('#notification-bell').on('click', function() {
        $('.header-notification').fadeIn(500);
    })
    $('.header-notification__delete__btn').on('click', function() {
        $('.header-notification').fadeOut(500);
    })
})