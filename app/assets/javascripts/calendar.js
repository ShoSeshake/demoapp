$(function() {
    function eventCalendar() {
        return $('#calendar').fullCalendar({});
    };

    function clearCalendar() {
        $('#calendar').html('');
    };

    $(document).ready(function() {
        $('#calendar').fullCalendar({
            titleFormat: 'YYYY年 MM月',
            selectable: true,
            //曜日を日本語表示
            dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
            //ボタンのレイアウト
            header: {
                left: '',
                center: 'title',
                right: 'today prev,next'
            },
            buttonText: {
                prev: '前',
                next: '次',
                prevYear: '前年',
                nextYear: '翌年',
                today: '今日',
                month: '月',
                week: '週',
                day: '日'
            },
        });

    });
});