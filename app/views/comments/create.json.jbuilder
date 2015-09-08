json.extract! @comment, :id, :text, :created_at, :updated_at
json.url point_url(@comment, format: :json)
json.user(@comment.user, :name, :id)
json.point(@comment.point, :name)
