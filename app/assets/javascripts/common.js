/**
 * Created by Геннадий on 28.08.2015.
 */
var USER_POSITION = {lng:0,lat:0}
navigator.geolocation.getCurrentPosition(function(position){
    USER_POSITION = {lat:position.coords.latitude,lng:position.coords.longitude};
});