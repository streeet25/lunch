Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['google_token'], ENV['google_key']
end

