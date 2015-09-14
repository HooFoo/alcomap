json.array!(@chat_messages) do |chat_message|
  json.extract! chat_message, :id, :message
  json.url chat_message_url(chat_message, format: :json)
  json.username chat_message.user.name
end
