json.extract! @point, :id, :lng, :lat, :name, :rating, :description, :updated_at, :isFulltime, :cardAccepted, :beer, :hard, :elite
json.url point_url(@point, format: :json)
json.user(@point.user, :name,:profile =>[:sex])
json.created_at @point.created_at.strftime("%d %b. %Y")
json.point_type(@point.point_type)
json.comments (@point.comments.reverse) do |comment|
  json.text comment.text
  json.id comment.id
  json.user do
    json.name comment.user.name
    json.id comment.user.id
  end
end
json.rated_by(@point.rated_points) do |rated|
  json.user rated.user.name
  json.direction rated.direction
end
json.editable (@point.user == current_user)

