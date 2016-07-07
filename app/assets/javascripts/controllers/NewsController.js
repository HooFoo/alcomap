/**
 * Created by �������� on 18.09.2015.
 */
function NewsController(News, $scope, ControllersProvider) {
    var $this = this;
    this.onlyMy = false;

    this.getIndex = function () {
        $('#news_scroller').toggleClass(' fadeIn fadeOut');
        News.index(function (result) {
            $this.news = result;
            $('#news_scroller').toggleClass(' fadeIn fadeOut');

        });
    };
    this.getMy = function () {
        $('#news_scroller').toggleClass(' fadeIn fadeOut');
        News.indexMy(function (result) {
            $this.news = result;
            $('#news_scroller').toggleClass(' fadeIn fadeOut');
        });
    };
    this.onlyMyChanged = function () {
        if ($this.onlyMy) {
            this.getMy();
            this.stopUpdate = true;
        }
        else {
            this.getIndex();
            this.stopUpdate = false;
        }
    };
    this.refresh = function () {
        if(!$this.onlyMy)
        {
            $this.getIndex();
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
            var id = $this.news.length > 0 ? $this.news[0].id : 0;
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