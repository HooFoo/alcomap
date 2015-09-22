/**
 * Created by Геннадий on 28.08.2015.
 */
function IndexController($compile, $scope, $http, gmap, Point, Comment, User) {
    var $this = this;

    this.heading = 'Алкомап β';
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
        if (window)
            window.open(gmap, marker);
    }

    var buildMarker = function (item) {
        var marker = new google.maps.Marker({
            position: {lng: item.lng, lat: item.lat},
            label: item.name,
            title: item.description,
            map: gmap,
            icon: iconForPoint(item.point_type)
        });
        var content = '<div id="info" ng-include src="\'' + asset_path("info.html") + '\'" ng-show="controller.currentPoint"></div>';
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
        item.infowindow = infoWindow;
        gmap.clusterer.addMarker(marker);

        return marker
    };
    this.trackUser = function () {
        updateUserPosition();
        if ($this.usersMarker) $this.usersMarker.setPosition(USER_POSITION);
        setTimeout($this.trackUser, 1000);
    };
    this.styleForInfo = function () {
        var style;
        switch ($this.currentPoint.point_type) {
            case "shop":
            {
                style = {
                    infobox_down: ""
                };
                break;
            }
            case "marker":
            {
                style = {
                    infobox_down: ""
                };
                break;
            }
            case "message":
            {
                style = {
                    infobox_down: "hidden"
                };
                break;
            }
        }
        return style;
    };
    this.addPointDraggable = function (type) {
        $scope.point = {lat: gmap.getCenter().lat(), lng: gmap.getCenter().lng(), point_type: type};

        var marker = new google.maps.Marker({
            position: $scope.point,
            label: $scope.point.name,
            title: $scope.point.description,
            map: gmap,
            draggable: true,
            icon: iconForPoint(type)
        });

        $scope.addMarker = marker;

        var content = "<div class='addBox' ng-include='\"" + asset_path('new_point.html') + "\"'></div>";
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
            if (result.data.rating)
                $this.currentPoint.rating = result.data.rating;
        });
    };
    this.setPointCurrent = function (point_id) {
        google.maps.event.addListenerOnce(map, 'idle', function () {
            $this.points.forEach(function (item) {
                if (item.id == point_id) {
                    google.maps.event.trigger(item.marker, 'click');
                }
            });
        });
    };

    this.deletePoint = function()
    {
        $http.delete('/points/' + $this.currentPoint.id);
        gmap.clusterer.removeMarker($this.currentPoint.marker);
        $this.currentPoint.marker.setMap(null);
        $this.currentPoint = undefined;
        closeOther(undefined,undefined)
    };

    this.setCenter = function (lat, lng, point_id) {
        gmap.setCenter({lat: lat, lng: lng});
        if (point_id)
            $this.setPointCurrent(point_id);
    };
    var init = function () {
        gmap.addListener('idle', $this.showMarkers);

        $this.usersMarker = new google.maps.Marker({
            position: USER_POSITION,
            label: "Ты здесь",
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