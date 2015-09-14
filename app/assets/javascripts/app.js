/**
 * Created by Геннадий on 28.08.2015.
 */
app = angular.module('alcomap', ['ngResource']);
app.controller('IndexController', IndexController, ['$compile', '$scope', '$http', 'gmap', 'Point', 'Comment', 'User']);
app.controller('ChatController', ChatController, ['$scope',  'ChatMessage', 'User']);
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
                "featureType": "water",
                "elementType": "all",
                "stylers": [{"color": "#46bcec"}, {"visibility": "on"}]
            }]
    });
    var mc = new MarkerClusterer(map);
    var clusterStyles = [
        {
            textColor: 'rgba(0, 161, 199, 0.62)',
            url: asset_path('bottle.png'),
            height: 32,
            width: 32,
            textSize: '43px'
        },
        {
            textColor: 'rgba(0, 161, 199, 0.62)',
            url: asset_path('bottle.png'),
            height: 32,
            width: 32,
            textSize: '43px'
        },
        {
            textColor: 'rgba(0, 161, 199, 0.62)',
            url: asset_path('bottle.png'),
            height: 32,
            width: 32,
            textSize: '43px'
        }
    ];
    mc.setStyles(clusterStyles);
    map.clusterer = mc;
    return map;
});
app.factory('BackendResourse', ['$resource', '$http', function ($resource, $http, name) {
    var resource = $resource('/' + name + '/:id.:format', null, {
        'update': {
            method: 'put'
        }
    });
    return function (name) {
        return {
            index: function (accept, reject) {
                $resource('/' + name + '.:format').query({id: null, format: 'json'}).$promise.then(accept, reject);
            },
            show: function (id, accept, reject) {
                resource.get({id: id, format: 'json'}).$promise.then(accept, reject);
            },
            edit: function (id, data, accept, reject) {
                resource.update({id: id, format: 'json'}, data).$promise.then(accept, reject);
            },
            new: function (data, accept, reject) {
                $resource('/' + name + '.:format').save({format: 'json'}, data).$promise.then(accept, reject);
            },
            delete: function (id, accept, reject) {
                resource.delete({id: id, format: 'json'}).$promise.then(accept, reject);
            }
        }
    }
}]);
app.factory('Point', ['$resource', 'BackendResourse', '$http', function ($resource, BackendResourse, $http) {
    var obj = BackendResourse('points');
    obj.index_optimised = function (bounds, accept, reject) {
        $resource('/points.:format').query({bounds: bounds, format: 'json'}).$promise.then(accept, reject);
    };

    obj.rate = function (pid, direction, accept, reject) {
        $http.post('points/rate/' + pid, {direction: direction}).then(accept, reject);
    };

    return obj;
}]);
app.factory('Comment', ['$resource', 'BackendResourse', function ($resource, BackendResourse) {
    var obj = BackendResourse('comments');
    return obj;

}]);
app.factory('ChatMessage', ['$resource','$http', 'BackendResourse', function ($resource, $http, BackendResourse) {
    var obj = BackendResourse('chat_messages');
    obj.latest = function (id, accept, reject) {
        $http.post('chat_messages/latest/', {last_message_id: id}).then(accept, reject);
    };
    return obj;

}]);
app.service('User', ['$resource', function ($resource) {
    var usr;
    if(!usr)
        usr = $resource('/user').get();
    return usr;
}]);
app.directive('myEnter', function () {
    return function (scope, element, attrs) {
        element.bind("keydown keypress", function (event) {
            if(event.which === 13) {
                scope.$apply(function (){
                    scope.$eval(attrs.myEnter);
                });

                event.preventDefault();
            }
        });
    };
});
app.run(['$http', function ($http) {
    $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content');
}]);
