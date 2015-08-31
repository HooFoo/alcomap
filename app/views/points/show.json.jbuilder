json.extract! @point, :id, :long, :lat, :name, :description, :created_at, :updated_at
json.url point_url(@point, format: :json)
json.user(@point.user, :name) unless defined? @point.user
json.comments(@point.comments, :user, :text)
