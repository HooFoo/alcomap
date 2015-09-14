class ChatMessagesController < InheritedResources::Base

  respond_to :json

  def create
    @chat_message = ChatMessage.new :message => params[:message],
                              :user => current_user
    @chat_message.save
    if ChatMessage.count > 50
      ChatMessage.first.destroy
    end
    render 'show'
  end

  def latest
    @chat_messages = ChatMessage.where("id > ?", params[:last_message_id])
    render 'index'
  end

  private

    def chat_message_params
      params.require(:chat_message).permit()
    end
end

