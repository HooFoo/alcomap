/**
 * Created by hoofoo on 24.01.16.
 */
function SocialController(Profile, $scope, ControllersProvider)
{
    var $this = this;
    this.current_profile = undefined;
    this.showProfile = function(user_id)
    {
        Profile.by_user(user_id,function(result){
            $this.current_profile = result.data;
        })
    };
    var init = function () {
        EventTarget.apply($this);
        ControllersProvider.social = $this;
    }();
}
SocialController.prototype = new EventTarget();
SocialController.prototype.constructor = SocialController;