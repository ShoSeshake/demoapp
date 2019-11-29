$(function() {
    var noReady = $('.no-ready');
    if (noReady) {
        var receivePeer = function() {
            var chatId = $('.chat-box').data('chat');
            $.ajax({
                url: '/chats/receive',
                type: 'get',
                dataType: 'script',
                data: {
                    id: chatId
                }
            })
        };
        setInterval(receivePeer, 3000);
    }
});