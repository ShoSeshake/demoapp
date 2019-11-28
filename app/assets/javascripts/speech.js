// $(function() {
//     SpeechRecognition = webkitSpeechRecognition || SpeechRecognition;
//     const speech = new SpeechRecognition();
//     speech.lang = 'ja-JP';
//     speech.continuous = true;
//     speech.interimResults = true;
//     //使用する変数を用意
//     const btn = document.getElementById('btn');
//     const content = document.getElementById('content');

//     let finalTranscript = ''; // 確定した(黒の)認識結果

//     btn.addEventListener('click', function() {
//         // 音声認識をスタート
//         speech.start();
//     });


//     speech.onresult = (event) => {
//         let interimTranscript = ''; // 暫定(灰色)の認識結果
//         for (let i = event.resultIndex; i < event.results.length; i++) {
//             let transcript = event.results[i][0].transcript;
//             if (event.results[i].isFinal) {
//                 finalTranscript += transcript;
//             } else {
//                 interimTranscript = transcript;
//             }
//         }
//         content.innerHTML = finalTranscript + '<i style="color:#ddd;">' + interimTranscript + '</i>';
//     }

// })