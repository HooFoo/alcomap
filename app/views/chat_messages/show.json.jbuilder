json.extract! @chat_message, :id, :created_at, :message
format = (Time.now-@chat_message.created_at < 1.day)? '%k:%m':'%m.%d'
json.created_at @chat_message.created_at.strftime(format)
json.username @chat_message.user.name
