# config/initializers/devise_async.rb
Devise::Async.setup do |config|
  config.enabled = true
  config.backend = :sidekiq
  config.queue   = :mailer
end

