json.extract! @point, :id, :lng, :lat, :name, :rating, :description, :created_at, :updated_at
json.url point_url(@point, format: :json)
json.user(@point.user, :name)
json.comments (@point.comments) do |comment|
  json.text comment.text
  json.id comment.id
  json.user do
    json.name comment.user.name
    json.id comment.user.id
  end
end
json.rated_by(@point.rated_points, :name, :id, :direction)



