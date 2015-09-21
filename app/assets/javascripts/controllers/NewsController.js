/**
 * Created by Геннадий on 18.09.2015.
 */
function NewsController(News, $scope) {
    var $this = this;

    this.wordForPointType = function(type)
    {
        switch(type)
        {
            case "message": return "сообщение";
            case "marker": return "событие";
            case "shop": return "магазин";
            case "bar": return "бар";
        }
    };

    this.update = function () {
        var id = $this.news ? $this.news[0].id : 0;
        News.latest(id, function (result) {
            if (result.data.length > 0) {
                result.data.forEach(function (msg) {
                    $this.news.unshift(msg);
                });
            }
        });
        setTimeout($this.update, 10000);
    };
    var init = function () {
        News.index(function (result) {
            $this.news = result;
        });
        setTimeout($this.update, 10000);
        $scope.wordForPoinType = $this.wordForPointType;
    };
    init();
}