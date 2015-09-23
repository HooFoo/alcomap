json.array!(@media) do |medium|
  json.extract! medium, :id, :comment_id, :user_id, :bin
  json.url medium_url(medium, format: :json)
end
