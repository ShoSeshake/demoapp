$(function() {
    var nextBtn = $('#adviser-next-btn');
    var preBtn = $('#adviser-pre-btn');
    nextBtn.on('click', function() {
        $('#signup-page1').animate({
            'left': '-200vw',
            'right': 'inherit'
        });
        $('#signup-page2').animate({
            'left': '0',
            'right': '0'
        })
    })
    preBtn.on('click', function() {
        $('#signup-page1').animate({
            'left': '0',
            'right': '0'
        });
        $('#signup-page2').animate({
            'left': 'inherit',
            'right': '-200vw'
        })
    })
})