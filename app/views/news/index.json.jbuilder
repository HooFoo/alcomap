json.array!(@news) do |news|
  puts news.inspect
  json.extract! news, :id
  json.created_at news.created_at.strftime '%k:%M  %b.%d'
  json.user news.user, :name unless news.user.nil?
  json.point news.point, :id, :name, :lat, :lng, :point_type unless news.point.nil?
  json.url news_url(news, format: :json)
end
