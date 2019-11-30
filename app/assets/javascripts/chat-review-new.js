$(function() {
    var hiddenField = $('#chat-review-score');
    var stars = $('.icon-star');
    stars.on('click', function() {
        var number = $(this).data('id')
        stars.css({
            'color': 'rgb(128, 128, 128)'
        });

        hiddenField.val('');
        hiddenField.val(number);
        stars.slice(0, number)
            .css({
                'color': '#FF6400'
            });
    })
})