$(function() {
    var notice = $('.notification');
    if (notice) {
        notice.fadeIn(200);
        var hideNotice = function() {
            notice.fadeOut(500);
        }
        setTimeout(hideNotice, 5000);
    }
})