function ChatController($scope, ChatMessage, User, ControllersProvider) {
    var $this = this;
    var container = $('.overflow_hidden');
    var messages = $('#messages');

    this.messages = undefined;
    this.lastUpdate = 0;
    this.enabled = false;
    this.user = User;
    this.online = 0;

    this.sendMessage = function () {
        if ($this.chatMessage.trim() != '')
            ChatMessage.new({message: $this.chatMessage}, function (result) {
                $this.chatMessage = '';
                delayedScroll();
            });
    };
    this.update = function () {
        var id = $this.messages ? $this.messages[$this.messages.length - 1].id : 0;
        ChatMessage.latest(id, function (result) {
            if (result.data.length > 0) {
                result.data.forEach(function (msg) {
                    if (msg.message && msg.message.indexOf($this.user.data.name) > -1) {
                        var audio = new Audio(asset_path('alert.mp3'));
                        audio.volume = 0.5;
                        audio.play();
                        msg.marked = true;
                    }
                    $this.messages.push(msg);
                    delayedScroll();
                });
            }
        });
        User.online_count(function(result){
                $this.online = result.data.value;
        });
        if ($this.messages)
            $this.lastUpdate = $this.messages[$this.messages.length - 1].id;
        setTimeout($this.update, 2500);
    };
    this.enable = function () {
        $this.enabled = !$this.enabled;
        if ($this.enabled)
            delayedScroll();
        container.toggleClass('deployed');
        container.toggleClass('undeployed');
    };
    this.selectUser = function (name) {
        $this.chatMessage = name + ", ";
        $('input.chat_msg_box').focus();
    };
    var init = function () {
        ControllersProvider.chat = $this;
        EventTarget.apply($this);
        $this.addListenerOnce('messagesloaded', $this.update);
        ChatMessage.index(function (result) {
            $this.messages = result;
            //ждем пока отрисуется
            setTimeout(function () {
                $this.fire('messagesloaded')
            },2000)
        });

    };
    var delayedScroll = function () {
        setTimeout(function () {
            messages.animate({scrollTop: messages[0].scrollHeight})
        }, 300);
    };
    init();
}
ChatController.prototype = new EventTarget();
ChatController.prototype.constructor = ChatController;