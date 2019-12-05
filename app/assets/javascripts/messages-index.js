$(function() {
    var MessagesBox = $('#messages-box');
    if (MessagesBox.length > 0) {
        var reloadMessages = function() {
            last_message_id = $('.message-box:last').data('message');
            $.ajax({
                url: '/api/messages/reload',
                type: 'get',
                dataType: 'script',
                data: {
                    message_id: last_message_id,
                    chat_id: gon.chat_id
                }
            })
        };
        setInterval(reloadMessages, 5000);
    }
});