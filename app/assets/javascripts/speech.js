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
//         for (let i = event.resultIndex; i < event.results.length; i++) {
//             let transcript = event.results[i][0].transcript;
//             if (event.results[i].isFinal) {
//                 var message = document.createElement("div");
//                 message.setAttribute("class", "video-message");

//                 message.innerHTML = transcript;
//                 content.appendChild(message);
//             }
//         }
//     }

// })