json.array!(@points) do |point|
  json.extract! point, :id, :long,:lat, :name, :description, :user_id
  json.url point_url(point, format: :json)
end
