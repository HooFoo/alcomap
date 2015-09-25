/**
 * Created by Геннадий on 28.08.2015.
 */
function IndexController($compile, $scope, $http, gmap, Point, Comment, User,ControllersProvider) {
    var $this = this;

    this.heading = 'Алкомап β';
    this.currentPoint = undefined;
    this.openedInfos = undefined;
    this.user = User;
    $this.points = [];

    var findPointInList = function (point) {
        var result = point;
        $this.points.forEach(function (item) {
            if (item.id == point.id)
                result = item;
        });
        return result;
    };
    function extractPoint(resource){
        return {
            id:resource.id,
            lat:resource.lat,
            lng:resource.lng,
            name:resource.name,
            point_type:resource.point_type,
            description:resource.description,
            isFulltime:resource.isFulltime,
            cardAccepted:resource.cardAccepted,
            beer:resource.beer,
            hard:resource.hard,
            elite:resource.elite
        }
    }
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

        marker.openInfo = function (event) {
            $this.currentPoint = findPointInList(item);
            $this.points.splice($this.points.indexOf(item), 1);
            gmap.clusterer.removeMarker(marker);
            marker.setMap(gmap);
            closeOther(infoWindow, marker);
        };
        marker.addListener('click', marker.openInfo);


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

    this.editPoint = function (id) {
        var point = undefined;
        this.points.forEach(function (item) {
            if (item.id == id)
                point = item;
        })
        if (point)
            $this.addPointDraggable(point.point_type, point)
        else
            $this.setPointCurrent(id);
    };
    this.addPointDraggable = function (type, point) {
        if (point)
            $this.isEditing = true;
        else
            $this.isEditing = false;
        $scope.point = point ? point : {
            lat: gmap.getCenter().lat(),
            lng: gmap.getCenter().lng(),
            point_type: type,
            isFulltime: true,
            cardAccepted: false,
            beer: true,
            hard: false,
            elite: false
        };

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
        if ($this.isEditing) {
            var point = Point.edit($scope.point.id,extractPoint($scope.point), function (result) {
                var marker = buildMarker(result);
            });
        }
        else
            var point = Point.new($scope.point, function (result) {
                var marker = buildMarker(result);
            });
        $scope.addMarker.setMap(null);
        closeOther(undefined, undefined);
        $this.showMarkers();
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
            $this.fire('onpointsloaded');
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
        var handler = function () {
            $this.setPointCurrent(point_id)
        };
        var was_set = false;

        if ($this.points)
            $this.points.forEach(function (item) {
                if (item.id == point_id) {
                    was_set = true;
                    item.marker.openInfo();
                }
            });
        if (!was_set) {
            $this.addListenerOnce('onpointsloaded', handler);
        }

    };

    this.deletePoint = function (id) {
        $http.delete('/points/' + id);
        $this.points.forEach(function(item){
            if(item.id==id)
            {
                gmap.clusterer.removeMarker(item.marker);
                item.marker.setMap(null);
                item = undefined;
                closeOther(undefined, undefined)
            }
        });
        ControllersProvider.news.removeNewsForPoint(id);
    };

    this.setCenter = function (lat, lng, point_id) {
        gmap.setCenter({lat: lat, lng: lng});
        if (point_id)
            $this.setPointCurrent(point_id);
    };
    var init = function () {
        EventTarget.apply($this);
        gmap.addListener('idle', $this.showMarkers);
        ControllersProvider.index = $this;
        $this.usersMarker = new google.maps.Marker({
            position: USER_POSITION,
            label: "Ты здесь",
            icon: {
                url: asset_path('Alien.png')
            },
            map: gmap
        });
        updateUserPosition();
        $this.trackUser();
        setTimeout($this.centerForUser(), 1500);
    }();
}
IndexController.prototype = new EventTarget();
IndexController.prototype.constructor = IndexController;