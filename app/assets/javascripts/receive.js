$(function() {
    var makeCall = $('#make-call');
    var callBtn = $('#callbtn');
    if (makeCall.length > 0) {
        var buildHTML = function(data) {
            var html = `<input id="their-id" type="hidden" value="${data.id}"></input>`
            return html;
        }
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
                .done(function(data) {
                    if (data.id) {
                        var html = buildHTML(data);
                        makeCall.prepend(html);
                        callBtn.prop("disabled", false);
                        callBtn.html("通話開始");
                        clearInterval(id);
                    }
                })
                .fail(function() {});
        };
        var id = setInterval(receivePeer, 3000);
    }
});