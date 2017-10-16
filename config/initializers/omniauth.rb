Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, ENV['VK_API_KEY'], ENV['VK_API_SECRET'], {:provider_ignores_state => true}
end