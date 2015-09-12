/**
 * Created by Геннадий on 28.08.2015.
 */
function IndexController($compile, $scope, $http, gmap, Point, Comment, User) {
    var $this = this;
    this.heading = 'Алкомап (альфа)';
    this.currentPoint = undefined;
    this.openedInfos = undefined;
    this.user = User;
    var findPointInList = function (point) {
        var result = point;
        $this.points.forEach(function (item) {
            if (item.id == point.id)
                result = item;
        });
        return result;
    };

    function closeOther(window, marker) {
        if ($this.openedInfos)
            $this.openedInfos.close();
        $this.openedInfos = window;
        if(window)
            window.open(gmap, marker);
    }

    var buildMarker = function (item) {
        var marker = new google.maps.Marker({
            position: {lng: item.lng, lat: item.lat},
            label: item.name,
            title: item.description,
            map: gmap,
            icon: asset_path('bottle.png')
        });

        //TODO: ужас
        var content = '<div id="info" ng-include src="\'' + asset_path("info.html")+'\'" ng-show="controller.currentPoint"></div>';
        var infoWindow = new google.maps.InfoWindow({
            content: content
        });

        infoWindow.addListener('domready', function () {
            $scope.$apply(function () {
                $compile(document.getElementById('info'))($scope);
            });
        });
        infoWindow.addListener('closeclick', function () {
            $this.points.push(item);
            marker.setMap(null);
            gmap.clusterer.addMarker(marker);
            $this.currentPoint = undefined;
            $scope.$apply();
        });

        marker.addListener('click', function (event) {
            $this.currentPoint = findPointInList(item);
            $this.points.splice($this.points.indexOf(item), 1);
            gmap.clusterer.removeMarker(marker);
            marker.setMap(gmap);
            closeOther(infoWindow, marker);
            $scope.$apply();
        });


        item.marker = marker;
        gmap.clusterer.addMarker(marker);

        return marker
    };
    this.trackUser = function () {
        updateUserPosition();
        if ($this.usersMarker) $this.usersMarker.setPosition(USER_POSITION);
        setTimeout($this.trackUser, 1000);
    };
    this.addPointDraggable = function () {
        $scope.point = {lat: gmap.getCenter().lat(), lng: gmap.getCenter().lng()};

        var marker = new google.maps.Marker({
            position: $scope.point,
            label: $scope.point.name,
            title: $scope.point.description,
            map: gmap,
            draggable: true,
            icon: asset_path('drinks.png')
        });

        $scope.addMarker = marker;

        var content = "<div class='addBox' ng-include='\""+asset_path('new_point.html')+"\"'></div>";
        var infoWindow = new google.maps.InfoWindow({
            content: content
        });
        infoWindow.addListener('domready', function () {
            $scope.$apply(function () {
                $compile(document.getElementsByClassName('addBox'))($scope);
            });
        });
        closeOther(infoWindow, marker);
        infoWindow.addListener('closeclick', function () {
            marker.setMap(null);
        });
        marker.addListener('dragend', function () {
            var pos = marker.getPosition();
            $scope.point.lng = pos.lng();
            $scope.point.lat = pos.lat();
            $scope.$apply();
        })
    };
    this.addPoint = function () {
        var point = Point.new($scope.point, function (result) {
            var marker = buildMarker(result);
        });
        $scope.addMarker.setMap(null);
        closeOther(undefined, undefined);
    };
    this.comment = function () {
        $scope.comment.point_id = $this.currentPoint.id;
        var comment = Comment.new($scope.comment, function (result) {
            $scope.comment.text = '';
            $this.currentPoint.comments.unshift(result);
        });

    };
    this.centerForUser = function () {
        gmap.setCenter(USER_POSITION);
        gmap.setZoom(14);
    };
    this.showMarkers = function () {
        var bounds = gmap.getBounds();
        Point.index_optimised(bounds, function (result) {
            gmap.clusterer.clearMarkers();
            $this.points = result;
            $this.points.forEach(function (item) {
                if (!(item.id == ($this.currentPoint ? $this.currentPoint.id : undefined)))
                    buildMarker(item);
                else
                    console.log("drop");
            });
        });
    };
    this.deleteComment = function (id) {
        $http.delete('/comments/' + id);
        $this.currentPoint.comments.forEach(function (item, index) {
            if (item.id == id)
                $this.currentPoint.comments.splice(index, 1);
        });
    };
    this.pointRate = function (dir) {
        Point.rate($this.currentPoint.id, dir, function (result) {
            if(result.rating)
                $this.currentPoint.rating = result.rating;
        });
    };
    var init = function () {
        gmap.addListener('idle', $this.showMarkers);

        $this.usersMarker = new google.maps.Marker({
            position: USER_POSITION,
            label: "Ето ты",
            icon: {
                url: asset_path('Alien.png')
            },
            map: gmap
        });
        updateUserPosition();
        $this.centerForUser();
        $this.trackUser();
    }();
}