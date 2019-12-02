$(function() {
    var schools = $('.index__box__flex__school');
    var advisers = $('.index__box__flex__adviser');
    schools.on('mouseenter', function() {
        var id = $(this).data('school');
        schools.css({
            'opacity': '0.5'
        })
        $(this).css({
            'opacity': '1'
        })
        var school = $("#school-description-" + id)
        $('.school-introduction').hide();
        school.fadeIn(500);
    })
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