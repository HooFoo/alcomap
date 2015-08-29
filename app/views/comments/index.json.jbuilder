json.array!(@comments) do |comment|
  json.extract! comment, :id, :text
  json.url comment_url(comment, format: :json)
end
