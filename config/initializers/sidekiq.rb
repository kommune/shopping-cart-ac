Sidekiq.configure_client do |config|
  config.redis = {size:3}
end