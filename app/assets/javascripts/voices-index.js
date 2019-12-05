$(function() {
    var VoicesBox = $('#content');
    if (VoicesBox.length > 0) {
        var reloadVoices = function() {
            last_voice_id = $('.voice-box:last').data('voice');
            $.ajax({
                url: '/api/voices/reload',
                type: 'get',
                dataType: 'script',
                data: {
                    voice_id: last_voice_id,
                    chat_id: gon.chat_id
                }
            })
        };
        setInterval(reloadVoices, 5000);
    }
})