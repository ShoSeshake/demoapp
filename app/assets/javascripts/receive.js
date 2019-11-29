$(function() {
    if (window.location.href.match(/\/chats\/\d+\/video/)) {
        var receivePeer = function() {
            var chatId = $('.chat-box').data('chat');
            $.ajax({
                    url: '/chats/receive',
                    type: 'get',
                    dataType: 'json',
                    data: {
                        id: chatId
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

        };
        setInterval(receivePeer, 3000);
    }
});