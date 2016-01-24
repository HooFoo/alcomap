/**
 * Created by hoofoo on 22.01.16.
 */
//TODO: Вынести всю логику работы с картой из IndexController.
function MapController($compile, $scope, $http, gmap, Point, Comment, User, ControllersProvider)
{
    var $this = this;
    var init = function () {
        EventTarget.apply($this);
        ControllersProvider.map = $this;
    }();

}
MapController.prototype = new EventTarget();
MapController.prototype.constructor = MapController;