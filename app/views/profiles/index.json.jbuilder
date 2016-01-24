json.array!(@profiles) do |profile|
  json.extract! profile, :id, :age, :sex, :comment, :user_id
  json.url profile_url(profile, format: :json)
end
