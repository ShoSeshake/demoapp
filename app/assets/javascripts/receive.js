$(function() {
    if (window.location.href.match(/\/chats\/\d+\/video/)) {
        var receivePeer = function() {
            if ($('#message_chat_id').length !== 0) {
                chatId = $('#message_chat_id').val();
                last_message_id = $('.chat__main__body__message:last').data('id');
                $.ajax({
                        url: 'chats/receive',
                        type: 'get',
                        dataType: 'json',
                        data: {
                            id: last_message_id
                        }
                    })
                    .done(function(messages) {
                        var insertHTML = '';
                        if (messages.length !== 0) {
                            messages.forEach(function(message) {
                                insertHTML = buildHTML(message);
                                $('.messages').append(insertHTML);
                                scroll();
                            });
                        }
                    })
                    .fail(function() {
                        alert('チャットIDを受信できませんでした');
                    });
            }
        };
        setInterval(receivePeer, 3000);
    }
});