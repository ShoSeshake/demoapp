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
    var areas = $('.area-middle__areas__area');
    areas.on('mouseenter', function() {
        var id = $(this).data('area');
        areas.css({
            'opacity': '0.5'
        })
        $(this).css({
            'opacity': '1'
        })
        var area = $("#area-description-" + id)
        $('.area-introduction').hide();
        area.fadeIn(500);
    })
})