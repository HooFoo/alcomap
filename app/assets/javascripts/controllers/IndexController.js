/**
 * Created by Геннадий on 28.08.2015.
 */
function IndexController($compile, $scope, $http, gmap, Point, Comment, User, ControllersProvider, Settings) {
    var $this = this;

    this.heading = 'Алкомап';
    this.currentPoint = undefined;
    this.openedInfos = undefined;
    this.user = User;
    this.settings = {};
    $this.points = [];

    var findPointInList = function (point) {
        var result = point;
        $this.points.forEach(function (item) {
            if (item.id == point.id)
                result = item;
        });
        return result;
    };

    function extractPoint(resource) {
        return {
            id: resource.id,
            lat: resource.lat,
            lng: resource.lng,
            name: resource.name,
            point_type: resource.point_type,
            description: resource.description,
            isFulltime: resource.isFulltime,
            cardAccepted: resource.cardAccepted,
            beer: resource.beer,
            hard: resource.hard,
            elite: resource.elite//,
            //picture: {
            //    data: resource.picture.link,
            //    filename: resource.picture.name
            //}
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
            title: item.name,
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

        infoWindow.onClose = function () {
            $this.points.push(item);
            marker.setMap(null);
            gmap.addMarker(marker, item.point_type);
            $this.currentPoint = undefined;
            //$scope.$apply();
        };
        infoWindow.addListener('closeclick', infoWindow.onClose);

        marker.openInfo = function (event) {
            $this.currentPoint = findPointInList(item);
            $this.points.splice($this.points.indexOf(item), 1);
            gmap.removeMarker(marker, item.point_type);
            marker.setMap(gmap);
            closeOther(infoWindow, marker);
        };
        marker.addListener('click', marker.openInfo);


        item.marker = marker;
        item.infowindow = infoWindow;
        gmap.addMarker(marker, item.point_type);

        return marker
    };
    this.trackUser = function () {
        updateUserPosition();
        if($this.lastUserPosition == USER_POSITION_DEFAULT &&
        USER_POSITION != USER_POSITION_DEFAULT)
            $this.centerForUser();
        if ($this.usersMarker)
            $this.usersMarker.setPosition(USER_POSITION);
        $this.lastUserPosition = USER_POSITION;
        setTimeout($this.trackUser, 2000);
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
        });
        if (point)
            $this.addPointDraggable(point.point_type, point)
        else
            $this.setPointCurrent(id);
    };
    this.addPointDraggable = function (type, point) {
        $this.isEditing = !!point;
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

    this.closePoint = function () {
        $this.openedInfos.onClose();
        closeOther(undefined, undefined);
    };
    this.addUserLocation = function()
    {
        Point.new(extractPoint({
            lat: USER_POSITION.lat,
            lng: USER_POSITION.lng,
            name: "Готов к общению!",
            point_type: "user",
        }), function (result) {
            var marker = buildMarker(result);
        });
    };
    this.addPoint = function () {
        if ($this.isEditing) {
            var point = Point.edit($scope.point.id, extractPoint($scope.point), function (result) {
                var marker = buildMarker(result);
            });
        }
        else
            var point = Point.new(extractPoint($scope.point), function (result) {
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
        if(bounds) {
            var parsed = {
                sw: {
                    lat: bounds.getSouthWest().lat(),
                    lng: bounds.getSouthWest().lng()
                },
                ne: {
                    lat: bounds.getNorthEast().lat(),
                    lng: bounds.getNorthEast().lng()
                }
            };


            Point.getPoints(parsed, function (result) {
                gmap.clearMarkers();
                $this.points = result.data;
                $this.points.forEach(function (item) {
                    if (!(item.id == ($this.currentPoint ? $this.currentPoint.id : undefined)))
                        buildMarker(item);
                });
                $this.fire('onpointsloaded');
            });
        }
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
                    item.comment
                }
            });
        if (!was_set) {
            $this.addListenerOnce('onpointsloaded', handler);
        }

    };
    this.prepareMessage = function (text) {
        return prepareMessage(text,"comment_link","comment_image");
    };
    this.deletePoint = function (id) {
        $http.delete('/points/' + id);
        $this.points.forEach(function (item) {
            if (item.id == id) {
                gmap.removeMarker(item.marker, item.point_type);
                item.marker.setMap(null);
                item = undefined;
                closeOther(undefined, undefined)
            }
        });
        ControllersProvider.news.removeNewsForPoint(id);
    };

    this.setCenter = function (lat, lng, point_id) {
        gmap.setCenter({lat: lat, lng: lng});
        gmap.setZoom(14);
        if (point_id)
            $this.setPointCurrent(point_id);
    };
    this.activateChat = function(name)
    {
        ControllersProvider.chat.activateWithName(name);
    };
    this.openWindow = function(title,href)
    {
        $("#window_wrapper").addClass("window_opened")
        $("#window_content").empty();
        $("#window_content").append("<iframe src='"+href+"'></iframe>");
    };
    this.closeWindow = function()
    {
        $("#window_wrapper").removeClass("window_opened")
    };
    var init = function () {
        EventTarget.apply($this);
        Settings.get(function(result){
            $this.settings = JSON.parse(result.data.json);
        });
        $scope.$watch('controller.settings', function (newValue, oldValue) {
            Settings.save(newValue);
            $this.showMarkers();
        }, true);

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