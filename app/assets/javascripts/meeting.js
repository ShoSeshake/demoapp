$(function() {
    const container = $('#video-container');
    if (container.length > 0) {
        let localStream = null;
        let existingCall = null;
        var myVideo = $('#my-video').get(0);
        var theirVideo = $('#their-video').get(0);
        var UserPeerId = $('#chat_user_peer_id');
        var makeCall = $('#make-call');
        var endCall = $('#end-call');
        var linkUrl = endCall.attr('action');

        // 自分の画面の表示
        navigator.mediaDevices = navigator.mediaDevices || ((navigator.mozGetUserMedia || navigator.webkitGetUserMedia) ? {
            getUserMedia: function(c) {
                return new Promise(function(y, n) {
                    (navigator.mozGetUserMedia ||
                        navigator.webkitGetUserMedia).call(navigator, c, y, n);
                });
            }
        } : null);

        if (!navigator.mediaDevices) {
            console.log("getUserMedia() not supported.");
            return;
        }
        var constraints = { audio: true, video: true };

        navigator.mediaDevices.getUserMedia(constraints)
            .then(function(stream) {
                myVideo.srcObject = stream;
                localStream = stream;
                myVideo.onloadedmetadata = function(e) {
                    myVideo.play();
                };
            })
            .catch(function(err) {
                console.log(err.name + ": " + err.message);
            });

        const peer = new Peer({ key: gon.skyway_key, debug: 3 });

        // skyway接続、USERならIDを表示
        if (UserPeerId) {
            peer.on('open', () => {
                UserPeerId.val(peer.id);
                $('#user_peer_btn').prop("disabled", false);
            });
        }

        // エラー
        peer.on('error', (err) => {
            alert(err.message);
        });

        // 相手と接続がきれた
        peer.on('close', () => {});

        // シグナリングサーバとの接続が切れた
        peer.on('disconnected', () => {});

        makeCall.on('submit', (e) => {
            e.preventDefault();
            const call = peer.call($('#their-id').val(), localStream);
            setupCallEventHandlers(call);
        });

        endCall.on('submit', (e) => {
            e.preventDefault();
            existingCall.close();
            notification();
        });

        peer.on('call', (call) => {
            call.answer(localStream);
            setupCallEventHandlers(call);
        });

        // 今回は既に接続中の場合は一旦既存の接続を切断し、後からきた接続要求を優先します。
        // また、切断処理等で利用するため、CallオブジェクトをexistingCallとして保持しておきます。
        function setupCallEventHandlers(call) {

            existingCall = call;
            // 相手のカメラ映像・マイク音声を受信した際に発火します。
            // 取得したStreamオブジェクトをvideo要素にセットします。
            call.on('stream', (stream) => {
                addVideo(call, stream);
                $('#end_call_btn').prop("disabled", false);
                if ($('#callbtn')) {
                    $('#callbtn').prop("disabled", true);
                }
                // 文字起こし関数を呼び出し
                speechToText();
                // 20分タイマー
                timer20min();
            });

            // call.close()による切断処理が実行され、実際に切断されたら発火
            call.on('close', () => {
                removeVideo(call.remoteId);
                notification();
            });
        }

        function addVideo(call, stream) {
            theirVideo.srcObject = stream;
            theirVideo.setAttribute('id', call.remoteId);
        }

        function removeVideo(peerId) {
            const element = document.getElementById(peerId);
            const container = element.parentElement;
            const newElement = document.createElement('video');
            newElement.setAttribute('id', 'their-video');
            container.insertBefore(newElement, element);
            container.removeChild(element);
        }

        function speechToText() {
            // 文字起こし機能
            SpeechRecognition = webkitSpeechRecognition || SpeechRecognition;
            const speech = new SpeechRecognition();
            // 言語の定義
            speech.lang = 'ja-JP';
            // 継続するか
            speech.continuous = true;
            // 途中経過の表示
            speech.interimResults = true
                // スピーチの開始
            speech.start();
            // 音声が入った時に発火
            speech.onresult = (event) => {
                for (let i = event.resultIndex; i < event.results.length; i++) {
                    var transcript = event.results[i][0].transcript;
                    if (event.results[i].isFinal) {
                        $('#chat-voice-text').val(transcript);
                        Rails.fire($('#chat-voice-form')[0], 'submit');
                    }
                }
            }
        }
        var timeUp = function() {
            // タイムアップ後のアクションをここで定義
            location.href = linkUrl;
        }
        var notification = function() {
            $('.dark-background').fadeIn(500);
            setTimeout(timeUp, 3000)
        }

        function timer20min() {
            $('#timer').countdowntimer({
                minutes: 20,
                timeUp: notification,
                labels: ['Minutes', 'Seconds']
            });
        }
    }
}, false);