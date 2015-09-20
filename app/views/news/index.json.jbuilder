json.array!(@news) do |news|
  json.extract! news, :id
  json.user news.user, :name
  json.point news.point, :id, :name, :lat, :lng
  json.url news_url(news, format: :json)
end
