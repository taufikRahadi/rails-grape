Sidekiq.configure_server do |config|
  config.redis = {url: "#{ENV['REDIS_URL']}:#{ENV['REDIS_PORT']}"}

  config.logger.level = Rails.logger.level
end

Sidekiq.configur_client do |config|
  config.redis = {url: "#{ENV['REDIS_URL']}:#{ENV['REDIS_PORT']}"}
end
