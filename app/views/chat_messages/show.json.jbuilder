json.extract! @chat_message, :id, :created_at, :message, :updated_at
json.username @chat_message.user.name
