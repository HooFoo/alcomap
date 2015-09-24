json.array!(@news) do |news|
  puts news.inspect
  json.extract! news, :id
  json.created_at news.created_at.strftime '%k:%M  %b.%d'
  json.user news.user, :name
  json.point news.point, :id, :name, :lat, :lng
  json.url news_url(news, format: :json)
end
