/**
 * Created by �������� on 28.08.2015.
 */
app = angular.module('alcomap', ['ngResource','ngSanitize']);
app.controller('IndexController', IndexController, ['$compile', '$scope', '$http', 'gmap', 'Point', 'Comment', 'User', 'ControllersProvider']);
app.controller('ChatController', ChatController, ['$scope','$sce', 'ChatMessage', 'User', 'ControllersProvider']);
app.controller('NewsController', NewsController, ['News', '$scope', 'ControllersProvider']);
app.factory('gmap', function () {
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 14,
        center: USER_POSITION,
        styles: [{
            "featureType": "administrative",
            "elementType": "labels.text.fill",
            "stylers": [{"color": "#444444"}]
        },
            {
                "featureType": "poi",
                "elementType": "geometry.fill",
                "stylers": [{"color": "#999999"}]
            },
            {
                "featureType": "landscape",
                "elementType": "all",
                "stylers": [{"color": "#f2f2f2"}]
            },
            {
                "featureType": "landscape",
                "elementType": "geometry.stroke",
                "stylers": [{"color": "#7C7C7C"}]
            },
            {
                "featureType": "poi",
                "elementType": "all",
                "stylers": [{"visibility": "off"}]
            }, {
                "featureType": "road",
                "elementType": "all",
                "stylers": [{"saturation": -100}, {"lightness": 45}]
            }, {
                "featureType": "road.highway",
                "elementType": "all",
                "stylers": [{"visibility": "simplified"}]
            }, {
                "featureType": "road.arterial",
                "elementType": "labels.icon",
                "stylers": [{"visibility": "off"}]
            }, {
                "featureType": "transit",
                "elementType": "all",
                "stylers": [{"visibility": "off"}]
            }, {
                "featureType": "transit.station",
                "elementType": "all",
                "stylers": [{"visibility": "on",
                    "color":"#FF22CC"}]
            }, {
                "featureType": "water",
                "elementType": "all",
                "stylers": [{"color": "#46bcec"}, {"visibility": "on"}]
            }]
    });
    // Create the search box and link it to the UI element.
    var input = document.getElementById('search_field');
    var searchBox = new google.maps.places.SearchBox(input);
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    // Bias the SearchBox results towards current map's viewport.
    map.addListener('bounds_changed', function() {
        searchBox.setBounds(map.getBounds());
    });
    searchBox.addListener('places_changed', function() {
        var places = searchBox.getPlaces();

        if (places.length == 0) {
            return;
        }
        map.setZoom(14);
        map.setCenter(places[0].geometry.location);
    });

        function mcFactory(point_type) {
        var styles = [
            {
                textColor: '#22A7F0',
                url: iconForPoint(point_type),
                height: 32,
                width: 32,
                textSize: 20
            },
            {
                textColor: '#22A7F0',
                url: iconForPoint(point_type),
                height: 42,
                width: 42,
                textSize: 25
            },
            {
                textColor: '#22A7F0',
                url: iconForPoint(point_type),
                height: 52,
                width: 52,
                textSize: 28
            }
        ];
        var mc = new MarkerClusterer(map);
        mc.setStyles(styles);
        return mc;
    }

    var clusterers = [];
    clusterers[POINT_TYPES.shop] = mcFactory(POINT_TYPES.shop);
    clusterers[POINT_TYPES.bar] = mcFactory(POINT_TYPES.bar);
    clusterers[POINT_TYPES.message] = mcFactory(POINT_TYPES.message);
    clusterers[POINT_TYPES.event] = mcFactory(POINT_TYPES.event);


    map.addMarker = function (marker, type) {
        clusterers[type].addMarker(marker)
    };
    map.removeMarker = function (marker, type) {
        clusterers[type].removeMarker(marker)
    };
    map.clearMarkers = function () {
        clusterers[POINT_TYPES.shop].clearMarkers();
        clusterers[POINT_TYPES.bar].clearMarkers();
        clusterers[POINT_TYPES.message].clearMarkers();
        clusterers[POINT_TYPES.event].clearMarkers();
    };
    return map;
});
app.factory('BackendResource', ['$resource', '$http', function ($resource, $http, name) {

    return function (name) {
        return {
            resource: $resource('/' + name + '/:id.:format', null, {
                'update': {
                    method: 'put'
                }
            }),
            index: function (accept, reject) {
                $resource('/' + name + '.:format').query({id: null, format: 'json'}).$promise.then(accept, reject);
            },
            show: function (id, accept, reject) {
                this.resource.get({id: id, format: 'json'}).$promise.then(accept, reject);
            },
            edit: function (id, data, accept, reject) {
                this.resource.update({id: id, format: 'json'}, data).$promise.then(accept, reject);
            },
            new: function (data, accept, reject) {
                $resource('/' + name + '.:format').save({format: 'json'}, data).$promise.then(accept, reject);
            },
            delete: function (id, accept, reject) {
                this.resource.delete({id: id, format: 'json'}).$promise.then(accept, reject);
            }
        }
    }
}]);
app.factory('Point', ['$resource', 'BackendResource', '$http', function ($resource, BackendResource, $http) {
    var obj = BackendResource('points');
    obj.index_optimised = function (bounds, accept, reject) {
        $resource('/points.:format').query({bounds: bounds, format: 'json'}).$promise.then(accept, reject);
    };
    obj.getPoints = function (bounds,settings, accept, reject) {
        $http.post('/points/get_points',{bounds: bounds, settings:settings}).then(accept, reject);
    };

    obj.rate = function (pid, direction, accept, reject) {
        $http.post('points/rate/' + pid, {direction: direction}).then(accept, reject);
    };

    return obj;
}]);
app.factory('Comment', ['$resource', 'BackendResource', function ($resource, BackendResource) {
    var obj = BackendResource('comments');
    return obj;

}]);
app.factory('ChatMessage', ['$resource', '$http', 'BackendResource', function ($resource, $http, BackendResource) {
    var obj = BackendResource('chat_messages');
    obj.latest = function (id, accept, reject) {
        $http.get('chat_messages/latest/' + id).then(accept, reject);
    };
    return obj;

}]);
app.factory('News', ['$resource', '$http', 'BackendResource', function ($resource, $http, BackendResource) {
    var obj = BackendResource('news');
    obj.indexMy = function (accept, reject) {
        $resource('news/my' + name + '.:format').query({id: null, format: 'json'}).$promise.then(accept, reject);

    };
    obj.latest = function (id, accept, reject) {
        $http.get('news/latest/' + id).then(accept, reject);
    };
    return obj;

}]);
app.service('User', ['$resource', '$http', function ($resource, $http) {
    var usr = {
        online_count: function (accept) {
            $http.get('user/onlinecount/').then(accept);
        }
    };
    usr.data = $resource('/user').get();

    return usr;
}]);
app.service('Settings', ['BackendResource', function (BackendResource) {
    var obj = BackendResource('settings');
    var settings = {
        settings: {
            points: {
                shops: true,
                marks: true
            },
            privacy: {
                show_me: false
            }
        },
        save: function () {
            obj.save({json: JSON.stringify(settings.settings)}, function (result) {
                settings.settings = JSON.parse(result.json);
            });
        }
    };
    obj.index(function (result) {
        if (result.json)
            settings.settings = JSON.parse(result.json);
    });
    return settings;
}]);
app.directive('myEnter', function () {
    return function (scope, element, attrs) {
        element.bind("keydown keypress", function (event) {
            if (event.which === 13) {
                scope.$apply(function () {
                    scope.$eval(attrs.myEnter);
                });

                event.preventDefault();
            }
        });
    };
});
app.directive("fileread", [function () {
    return {
        scope: {
            fileread: "="
        },
        link: function (scope, element, attributes) {
            element.bind("change", function (changeEvent) {
                var reader = new FileReader();
                reader.onload = function (loadEvent) {
                    scope.$apply(function () {
                        scope.fileread = loadEvent.target.result;
                    });
                }
                reader.readAsDataURL(changeEvent.target.files[0]);
            });
        }
    }
}]);
app.service('ControllersProvider', function () {
    return {
        chat: undefined,
        news: undefined,
        index: undefined
    }
});
app.run(['$http', function ($http) {
    $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content');
    $('body').keypress(function (event) {
        switch (event.which) {
            case 96:
            {
                $('.screen_label').trigger('click');
                break;
            }
        }
    })
}]);
