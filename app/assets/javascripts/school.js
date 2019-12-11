$(function() {
    var advisers = $('.area-middle__advisers__adviser');
    advisers.on('mouseenter', function() {
        var id = $(this).data('adviser');
        advisers.css({
            'opacity': '0.5'
        })
        $(this).css({
            'opacity': '1'
        })
        var adviser = $("#adviser-description-" + id)
        $('.adviser-introduction').hide();
        adviser.fadeIn(500);
    })
})