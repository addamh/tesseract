Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['twitter_consumer_key'], ENV['twitter_consumer_secret']
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user"
  provider :linkedin, ENV['linkedin_consumer_key'], ENV['linkedin_consumer_secret']
end