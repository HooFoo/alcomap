function ChatController($scope,$sce, ChatMessage, User, ControllersProvider) {
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
                        if(window.Notification)
                            new Notification("Кто-то позвал вас на алкокарте!",{
                                body : msg.message,
                                icon : asset_path('message_notify.jpg')
                            });
                        msg.marked = true;
                    }
                    msg.message = $this.prepareMessage(msg.message);
                    $this.messages.push(msg);
                    delayedScroll();
                });
            }
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
    this.prepareMessage = function (text) {
        return prepareMessage(text,"chat_link","chat_image");
    };
    this.selectUser = function (name) {
        $this.chatMessage = name + ", ";
        $('input.chat_msg_box').focus();
    };
    this.updateUserCount = function()
    {
        User.online_count(function (result) {
            $this.online = result.data.value;
        });
        setTimeout($this.updateUserCount,10000);
    };
    this.activateWithName = function(name)
    {
        $this.enabled = false;
        this.enable();
        this.chatMessage = name + ", ";
        $('input.chat_msg_box').focus();
    };
    var init = function () {
        ControllersProvider.chat = $this;
        EventTarget.apply($this);
        $this.addListenerOnce('messagesloaded', $this.update);
        ChatMessage.index(function (result) {
            $this.messages = result;
            $this.messages.forEach(function (msg) {
                msg.message = $this.prepareMessage(msg.message);
            });
            //ждем пока отрисуется
            setTimeout(function () {
                $this.fire('messagesloaded')
            }, 2000)
        });
        $this.updateUserCount();
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