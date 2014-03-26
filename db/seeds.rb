# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
    Role.where(name: role).first_or_create
      puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.where(email: ENV['ADMIN_EMAIL']).first_or_create(name: ENV['ADMIN_NAME'], password: ENV['ADMIN_PASSWORD'], password_confirmation: ENV['ADMIN_PASSWORD'])
puts 'user: ' << user.name
user.save!(:validate => false)
user.add_role :admin

(1..3).each do |i|
  user = User.where(email: "tester#{i}@cywin.cn").first_or_create(name: "tester#{i}", password: '11111111', password_confirmation: '11111111')
  puts 'user created: ' << user.name
end
