/**
 * Created by Геннадий on 18.09.2015.
 */
function NewsController(News, $scope, ControllersProvider) {
    var $this = this;
    this.onlyMy = false;

    this.onlyMyChanged = function () {
        if ($this.onlyMy) {
            $('#news_scroller').toggleClass(' fadeIn fadeOut');
            News.indexMy(function (result) {
                $this.news = result;
                $('#news_scroller').toggleClass(' fadeIn fadeOut');
            });
            this.stopUpdate = true;
        }
        else {
            $('#news_scroller').toggleClass(' fadeIn fadeOut');
            News.index(function (result) {
                $this.news = result;
                $('#news_scroller').toggleClass(' fadeIn fadeOut');

            });
            this.stopUpdate = false;
        }
    };
    this.more = function () {
        News.indexMy($this.news.length, function (result) {
            result.forEach(function (item) {
                $this.news.push(item);
            });
        });
    };

    this.update = function () {
        if (!$this.stopUpdate) {
            var id = $this.news ? $this.news[0].id : 0;
            News.latest(id, function (result) {
                if (result.data.length > 0) {
                    result.data.forEach(function (msg) {
                        $this.news.unshift(msg);
                    });
                }
            });
        }
        setTimeout($this.update, 10000);
    };
    this.removeNewsForPoint = function(point_id)
    {
      $this.news.forEach(function(item){
          if(item.point.id==point_id)
          {
              $this.news.splice($this.news.indexOf(item),1);
          }
      })
    };

    var init = function () {
        ControllersProvider.news = $this;
        News.index(function (result) {
            $this.news = result;
        });
        setTimeout($this.update, 10000);
    };
    init();
}