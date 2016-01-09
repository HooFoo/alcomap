class ChatMessagesController < InheritedResources::Base

  respond_to :json

  def create
    last = ChatMessage.last

    unless last.message == params[:message] and last.user == current_user
      @chat_message = ChatMessage.new :message => params[:message],
                                      :user => current_user
      @chat_message.save
      if ChatMessage.count > 50
        ChatMessage.first.destroy
      end
    end

    render 'show'
  end

  def latest
    Rails.logger.silence do
      @chat_messages = ChatMessage.where("id > ?", params[:id])
    end
    render 'index'
  end

  def index
    @chat_messages = ChatMessage.all.reorder(:id)
  end

  private

  def chat_message_params
    params.require(:chat_message).permit()
  end
end

