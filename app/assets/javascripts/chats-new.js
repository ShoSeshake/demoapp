$(function() {
    $(document).on('click', '.fc-past', function() {
        alert('その日程は選べません。');
    });
    $(document).on('click', '.fc-today', function() {
        alert('その日程は選べません。');
    });
    $(document).on('click', '.fc-future', function() {
        var date = $(this).data('date').split('-');
        $('#chat_start_at_1i').val(Number(date[0]));
        $('#chat_start_at_2i').val(Number(date[1]));
        $('#chat_start_at_3i').val(Number(date[2]));
        $('.reserve-date__year').text(Number(date[0]));
        $('.reserve-date__month').text(Number(date[1]));
        $('.reserve-date__day').text(Number(date[2]));
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