Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "consumer_key", "consumer_secret"
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user"
end