function ChatController($scope, ChatMessage, User) {
    var $this = this;
    var scrollable = document.getElementById('messages');

    this.messages = undefined;
    this.lastUpdate = 0;
    this.enabled = false;
    this.user = User;

    this.sendMessage = function () {
        if ($this.chatMessage != '')
            ChatMessage.new({message: $this.chatMessage}, function (result) {
                $this.messages.push(result);
                $this.chatMessage = '';
                delayedScroll();
            });
    };
    this.update = function () {
        var id = $this.messages?$this.messages[$this.messages.length - 1].id:0;
        ChatMessage.latest( id, function (result) {
            if (result.data.length > 0) {
                result.data.forEach(function (msg) {
                    $this.messages.push(msg);
                });
                delayedScroll();
            }
        });

        if ($this.messages)
            $this.lastUpdate = $this.messages[$this.messages.length - 1].id;
        setTimeout(function () {
            $this.update();
        }, 2500);
    };
    this.enable = function () {

        // -> triggering reflow /* The actual magic */
        // without this it wouldn't work. Try uncommenting the line and the transition won't be retriggered.
        element = document.getElementById("chat_area");
        element.offsetWidth = element.offsetWidth;
        $this.enabled = !$this.enabled;
    };
    var init = function () {
        ChatMessage.index(function (result) {
            $this.messages = result;

            delayedScroll();
        });
        setTimeout($this.update,2500);
    };
    var delayedScroll = function () {
        setTimeout(function () {
            scrollable.scrollTop = scrollable.scrollHeight;
        }, 500);
    }
    init();
}