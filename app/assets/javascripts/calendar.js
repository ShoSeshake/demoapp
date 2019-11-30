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
                left: 'prev, title',
                right: 'next'

            },
            buttonText: {
                prev: '<',
                next: '>',
                today: '今日',
                month: '月',
                week: '週',
                day: '日'
            },
        });
    });
});