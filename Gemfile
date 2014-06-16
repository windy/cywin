if ENV['RUBYTAOBAO']
  #puts "use taobao source"
  source 'http://ruby.taobao.org'
else
  source 'https://rubygems.org'
end
ruby '2.0.0'
gem 'rails', '4.1.0'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.1'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'cancancan', '~> 1.7'
gem 'compass-rails'
gem 'devise'
gem 'devise-async'
gem 'devise_invitable'
gem 'figaro'
gem 'rolify'
gem 'simple_form'
gem 'slim-rails'
gem 'therubyracer', :platform=>:ruby
gem "foundation-rails", "~> 5.2.2.0"
gem 'settingslogic'
gem 'foundation-icons-sass-rails'
gem 'kaminari', github: 'amatsuda/kaminari'
gem 'progress_bar'
gem 'sunspot_rails'
gem 'sunspot_solr'

#background cron
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', require: nil

# for observers
gem 'rails-observers'

gem 'state_machine'

# for sns login
gem 'omniauth-weibo-oauth2'
gem 'weibo2'
gem 'oauth'
gem 'oauth_china'

# for upload picture
gem 'mini_magick'
gem 'carrierwave'

gem 'angularjs-rails'

# i18n
gem 'rails-i18n', '~> 4.0.0'

# web server
gem 'unicorn'

# deploy
gem 'mina', require: false
gem 'mina-sidekiq', require: false

group :development do
  gem 'spring'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem "spring-commands-rspec"
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails', '2.14.2'
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-sidekiq'
end
