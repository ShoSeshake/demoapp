$(function() {
    const container = $('#video-container');
    if (container) {
        let localStream = null;
        let existingCall = null;
        var myVideo = $('#my-video').get(0);
        var theirVideo = $('#their-video').get(0);
        var myId = $('#my-id');
        var theirId = $('#their-id');
        var makeCall = $('#make-call');
        var endCall = $('#end-call');
        var callingId = $('#calling-id');


        // 自分の画面の表示
        navigator.mediaDevices.getUserMedia({ video: true, audio: true })
            .then(function(stream) {
                myVideo.srcObject = stream;
                localStream = stream;
            }).catch(function(error) {
                console.error('mediaDevice.getUserMedia() error:', error);
                return;
            });

        const peer = new Peer({ key: gon.skyway_key, debug: 3 });

        // skyway接続、自分のIDを表示
        peer.on('open', () => {
            document.getElementById('my-id').innerText = peer.id;
        });

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
            const call = peer.call(callingId.val(), localStream);
            setupCallEventHandlers(call);
        });

        endCall.on('submit', (e) => {
            e.preventDefault();
            existingCall.close();
        });

        peer.on('call', (call) => {
            call.answer(localStream);
            setupCallEventHandlers(call);
        });

        // 今回は既に接続中の場合は一旦既存の接続を切断し、後からきた接続要求を優先します。
        // また、切断処理等で利用するため、CallオブジェクトをexistingCallとして保持しておきます。
        function setupCallEventHandlers(call) {
            if (existingCall) {
                existingCall.close();
            }

            existingCall = call;

            // 相手のカメラ映像・マイク音声を受信した際に発火します。
            // 取得したStreamオブジェクトをvideo要素にセットします。
            call.on('stream', (stream) => {
                debugger
                addVideo(call, stream);
                setupEndCallUI();
                theirId.innerText = call.remoteId;

                SpeechRecognition = webkitSpeechRecognition || SpeechRecognition;
                const speech = new SpeechRecognition();
                speech.lang = 'ja-JP';
                recognition.continuous = true;
                speech.interimResults = true;
                let finalTranscript = '';
                speech.start();
                speech.onresult = (event) => {
                    let interimTranscript = ''; // 暫定(灰色)の認識結果
                    for (let i = event.resultIndex; i < event.results.length; i++) {
                        let transcript = event.results[i][0].transcript;
                        if (event.results[i].isFinal) {
                            finalTranscript += transcript;
                        } else {
                            interimTranscript = transcript;
                        }
                    }
                    content.innerHTML = finalTranscript + '<i style="color:#ddd;">' + interimTranscript + '</i>';
                }

            });

            // call.close()による切断処理が実行され、実際に切断されたら発火
            call.on('close', () => {
                removeVideo(call.remoteId);
                setupMakeCallUI();
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

        function setupMakeCallUI() {
            // makeCall.style.display = 'block';
            // endCall.style.display = 'none';
        }

        function setupEndCallUI() {
            // makeCall.style.display = 'none';
            // endCall.style.display = 'block';
        }
    }
}, false);