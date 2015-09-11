/**
 * Created by Геннадий on 28.08.2015.
 */
app = angular.module('alcomap', ['ngResource']);
app.controller('IndexController', IndexController, ['$compile', '$scope', '$http', 'gmap', 'Point', 'Comment', 'User']);
app.factory('gmap', function () {
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 14,
        center: USER_POSITION,
        styles: [{
            "featureType": "administrative",
            "elementType": "labels.text.fill",
            "stylers": [{"color": "#444444"}]
        }, {"featureType": "landscape", "elementType": "all", "stylers": [{"color": "#f2f2f2"}]}, {
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
        }, {"featureType": "water", "elementType": "all", "stylers": [{"color": "#46bcec"}, {"visibility": "on"}]}]
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
app.factory('Point', ['$resource', '$http', function ($resource, $http) {
    var resource = $resource('/points/:id.:format', null, {
        'update': {
            method: 'put'
        }
    });
    return {
        index: function (accept, reject) {
            $resource('/points.:format').query({id: null, format: 'json'}).$promise.then(accept, reject);
        },
        show: function (id, accept, reject) {
            resource.get({id: id, format: 'json'}).$promise.then(accept, reject);
        },
        edit: function (id, data, accept, reject) {
            resource.update({id: id, format: 'json'}, data).$promise.then(accept, reject);
        },
        new: function (data, accept, reject) {
            $resource('/points.:format').save({format: 'json'}, data).$promise.then(accept, reject);
        },
        delete: function (id, accept, reject) {
            resource.delete({id: id, format: 'json'}).$promise.then(accept, reject);
        },
        index_optimised: function (bounds, accept, reject) {
            $resource('/points.:format').query({bounds: bounds, format: 'json'}).$promise.then(accept, reject);

        },
        rate: function (pid, direction, accept, reject) {
            $http.post('points/rate/' + pid, {direction: direction}).then(accept, reject);
        }
    }
}]);
app.factory('Comment', ['$resource', function ($resource) {
    var resource = $resource('/comments/:id.:format', null, {
        'update': {
            method: 'put'
        }
    });
    return {
        index: function (accept, reject) {
            $resource('/comments.:format').query({id: null, format: 'json'}).$promise.then(accept, reject);
        },
        show: function (id, accept, reject) {
            resource.get({id: id, format: 'json'}).$promise.then(accept, reject);
        },
        edit: function (id, data, accept, reject) {
            resource.update({id: id, format: 'json'}, data).$promise.then(accept, reject);
        },
        new: function (data, accept, reject) {
            $resource('/comments.:format').save({format: 'json'}, data).$promise.then(accept, reject);
        },
        delete: function (id, accept, reject) {
            resource.delete({id: id, format: 'json'}).$promise.then(accept, reject);
        }
    }
}]);
app.factory('User', ['$resource', function ($resource) {
    return $resource('/user').get();
}]);
//app.config(['$locationProvider',function($locationProvider){
//    $locationProvider.html5Mode(true);
//}]);
app.run(['$http', function ($http) {
    $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content');
}]);
