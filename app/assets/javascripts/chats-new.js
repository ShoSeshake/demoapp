$(function() {

    $(document).on('click', '.fc-past', function() {
        alert('その日程は選べません。');
    });
    $(document).on('click', '.fc-today', function() {
        alert('その日程は選べません。');
    });
    $(document).on('click', '.fc-future', function() {
        var date = $(this).data('date').split('-');
        var newDate = $(this).data('date');
        console.log(gon.chats)
        $('#chat_start_at_1i').val(Number(date[0]));
        $('#chat_start_at_2i').val(Number(date[1]));
        $('#chat_start_at_3i').val(Number(date[2]));
        $('.reserve-date__year').text(Number(date[0]));
        $('.reserve-date__month').text(Number(date[1]));
        $('.reserve-date__day').text(Number(date[2]));
        $('#chat-new-btn').prop("disabled", true);
        $('#chat_start_at_4i').val('');
        $('#chat_start_at_5i').val('');
        $('.reserve-time__hour').text('');
        $('.reserve-time__min').text('');
        $('.chat-new__time__list').hide();
        $('.chat-new__time__list__btn').prop("disabled", false);

        gon.chats.forEach(function(e) {
            var datetime = e.split(':');
            if (newDate == datetime[0]) {
                bookedTime = $('.booked-' + datetime[1])
                bookedTime.prop("disabled", true);
            }
        })


        if ($(this).hasClass('fc-mon')) {
            $('.schedule-monday').fadeIn(500);
            $('.schedule-monday').css({
                'display': 'inline-block'
            })
        } else if ($(this).hasClass('fc-tue')) {
            $('.schedule-tuesday').fadeIn(500);
            $('.schedule-tuesday').css({
                'display': 'inline-block'
            })
        } else if ($(this).hasClass('fc-wed')) {
            $('.schedule-wednesday').fadeIn(500);
            $('.schedule-wednesday').css({
                'display': 'inline-block'
            })
        } else if ($(this).hasClass('fc-thu')) {
            $('.schedule-thursday').fadeIn(500);
            $('.schedule-thursday').css({
                'display': 'inline-block'
            })
        } else if ($(this).hasClass('fc-fri')) {
            $('.schedule-friday').fadeIn(500);
            $('.schedule-friday').css({
                'display': 'inline-block'
            })
        } else if ($(this).hasClass('fc-sat')) {
            $('.schedule-saturday').fadeIn(500);
            $('.schedule-saturday').css({
                'display': 'inline-block'
            })
        } else if ($(this).hasClass('fc-sun')) {
            $('.schedule-sunday').fadeIn(500);
            $('.schedule-sunday').css({
                'display': 'inline-block'
            })
        }
    });

    $(document).on('click', '.chat-new__time__list__btn', function() {

        var time = $(this).data('time').split(':');
        $('#chat_start_at_4i').val(time[0]);
        $('#chat_start_at_5i').val(time[1]);
        $('.reserve-time__hour').text(time[0] + '時');
        $('.reserve-time__min').text(time[1] + '分');
        $('#chat-new-btn').prop("disabled", false);
    });

})
$(function() {
    $(document).on('click', '#chat-new-modal', function() {
        var removeModal = function() {
            $('#chat-new-modal').remove();
            $('.chat-new').remove();
        }
        $(this).fadeOut(500);
        $('.chat-new').fadeOut(500);
        setTimeout(removeModal, 700);
    })
})