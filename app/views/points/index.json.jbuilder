json.array!(@points) do |point|
  json.extract! point, :id, :lng, :lat, :name, :rating, :description, :isFulltime, :cardAccepted, :beer, :hard, :elite
  json.created_at point.created_at.strftime("%d %b. %Y")
  json.url point_url(point, format: :json)
  json.user(point.user, :name)
  json.point_type(point.point_type)
  json.editable (point.user == current_user)

  json.comments (point.comments.reverse) do |comment|
    json.text comment.text
    json.id comment.id
    json.user do
      json.name comment.user.name
      json.id comment.user.id
    end
  end
  json.rated_by(point.rated_points) do |rated|
    json.user rated.user.name
    json.direction rated.direction
  end
end
