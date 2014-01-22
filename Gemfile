if ENV['RUBYTAOBAO']
  puts "use taobao source"
  source 'http://ruby.taobao.org'
else
  source 'https://rubygems.org'
end
ruby '2.0.0'
gem 'rails', '4.0.0'
gem 'sqlite3'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 1.2'
gem 'cancan'
gem 'compass-rails'
gem 'devise'
gem 'devise_invitable'
gem 'figaro'
gem 'rolify'
gem 'sendgrid'
gem 'simple_form'
gem 'slim-rails'
gem 'therubyracer', :platform=>:ruby
gem 'foundation-rails'

# For sns login
gem 'omniauth-weibo-oauth2'
gem 'weibo2'
gem 'oauth'
gem 'oauth_china'
# For user custom message
gem 'mailboxer'

# For upload picture
gem 'carrierwave'

# For deploy
gem 'capistrano'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'haml-rails'
  gem 'haml2slim'
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'guard-rails'
  gem 'guard-rspec', require: false
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'pry'
end

group :test do
  gem 'database_cleaner'
end
