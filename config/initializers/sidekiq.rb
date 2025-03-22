Sidekiq.configure_server do |config|
  redis_config = { namespace: ENV['SIDEKIQ_NAMESPACE'] }

  # Use REDIS_URL if provided
  if ENV['REDIS_URL'].present?
    redis_config[:url] = ENV['REDIS_URL']
  else
    # Otherwise use individual connection parameters
    redis_config[:host] = ENV['REDIS_HOST'] || 'localhost'
    redis_config[:port] = (ENV['REDIS_PORT'] || 6379).to_i
  end

  # Add password if provided
  redis_config[:password] = ENV['REDIS_PASSWORD'] if ENV['REDIS_PASSWORD'].present?
  
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  redis_config = { namespace: ENV['SIDEKIQ_NAMESPACE'] }

  # Use REDIS_URL if provided
  if ENV['REDIS_URL'].present?
    redis_config[:url] = ENV['REDIS_URL']
  else
    # Otherwise use individual connection parameters
    redis_config[:host] = ENV['REDIS_HOST'] || 'localhost'
    redis_config[:port] = (ENV['REDIS_PORT'] || 6379).to_i
  end

  # Add password if provided
  redis_config[:password] = ENV['REDIS_PASSWORD'] if ENV['REDIS_PASSWORD'].present?
  
  config.redis = redis_config
end