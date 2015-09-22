json.array!(@chat_messages) do |chat_message|
  json.extract! chat_message, :id, :message
  format = (Time.now-Time.at(chat_message.created_at) < 1.day)? '%k:%m':'%m.%d'
  json.created_at Time.at(chat_message.created_at).strftime(format)
  json.username chat_message.user.name
end
