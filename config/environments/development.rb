Eachfund::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  config.action_mailer.smtp_settings = {
    address: "smtp.sendgrid.net",
    port: 25,
    domain: ENV["DOMAIN_NAME"],
    authentication: "plain",
    user_name: ENV["SENDGRID_USERNAME"],
    password: ENV["SENDGRID_PASSWORD"]
  }
  # Send email in development mode.
  config.action_mailer.perform_deliveries = true

  # Setting for authentication of sns
  SERVICES = YAML.load_file(Rails.root.join("config", "service.yml")).fetch(Rails.env)
  Weibo2::Config.api_key = SERVICES['weibo']['api_key']
  Weibo2::Config.api_secret = SERVICES['weibo']['api_secret']
  Weibo2::Config.redirect_uri = SERVICES['weibo']['redirect_uri']

end
