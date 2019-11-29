$(function() {
    var elem = $("#RealtimeClock");
    if (elem.length > 0) {
        function digitalClock() {
            // 現在日時を取得
            var now = new Date();
            // 「時」を取得
            var hour = now.getHours();
            // 「分」を取得
            var minute = now.getMinutes();
            // 「秒」を取得
            var second = now.getSeconds();

            // 0埋めで2桁表示にする　例）08:45:09
            if (hour < 10) hour = "0" + hour;
            if (minute < 10) minute = "0" + minute;
            if (second < 10) second = "0" + second;

            // 現在時刻を表示する
            elem.html(hour + ":" + minute + ":" + second);

            // 500ミリ秒後に再帰呼び出し
            setTimeout(digitalClock, 500);
        }

        window.onload = function() {
            digitalClock();
        }
    }
});