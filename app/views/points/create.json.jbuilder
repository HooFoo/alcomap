json.extract! @point, :id, :lng, :lat, :name, :description, :created_at, :updated_at
json.url point_url(@point, format: :json)
json.user(@point.user, :name)
json.comments(@point.comments, :user, :text)

