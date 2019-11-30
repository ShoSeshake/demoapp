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
    });
})