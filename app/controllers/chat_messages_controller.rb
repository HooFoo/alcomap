class ChatMessagesController < InheritedResources::Base

  respond_to :json

  def create
    @chat_messages = ChatMessage.new :message => params[:message],
                              :user => current_user
    @chat_messages.save
    if ChatMessage.count >50
      ChatMessage.first.destroy
    end
    render 'show'
  end
  private

    def chat_message_params
      params.require(:chat_message).permit()
    end
end

