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
user.confirm!
user.add_role :admin

#(1..3).each do |i|
  #user = User.where(email: "tester#{i}@cywin.cn").first_or_create(name: "tester#{i}", password: '11111111', password_confirmation: '11111111')
  #user.confirm!
  #puts 'user created: ' << user.name
#end

puts 'DEFAULT categories'
YAML.load_file(File.join(Rails.root, 'config', 'default_categories.yml')).each do |head_name,categories|
  h = Head.find_or_create_by(name: head_name)
  categories.each do |category_name|
    c = Category.find_or_create_by(name: category_name)
    c.head = h
    c.save!
  end
end

puts 'DEFAULT cities'
['深圳', '上海', '北京', '成都', '西安', '广州', '杭州'].each do |name|
  City.find_or_create_by(name: name)
end

puts 'DEFAULT law iterms'
[
  {
    title: '反稀释',
    description: '（1）若乙方对任一股东或任何第三方新增注册资本（以下简称增资），甲方有权优先按相应比例以同样的价格同时认购相应的增资，以使其在增资后持有的项目公司股权比例不低于其根据本协议持有的项目公司股权比例。
（2）若乙方以比本次交易更优惠的价格和条件进行新的增资，乙方或丙方须采取相关措施确保增资后甲方所持股权的价值不低于新投资者进入前其股权的价值。',
  },
  {
    title: '优先购买权',
    description: '若乙方股东拟转让其股权，则在同等条件下，甲方享有优先购买权。',
  },
  {
    title: '共同出售权',
    description: '若乙方股东拟向除甲方外的其他股东或任何第三方转让其持有的乙方部分或全部股权，则甲方有权就其持有的乙方股权，按照同样的价格和其它条件，与该股东按照持有乙方股权的相对比例向该第三方共同转让。',
  },
  {
    title: '清算优先权',
    description: '在乙方清算、解散、合并、被收购、出售控股股权、出售全部资产时，甲方有权优先于其他股东获得原投资金额加上已宣布但尚未支付的红利。剩余资产由股东按持股比例进行分配。',
  },
].each do |law_iterm|
  LawIterm.where(title: law_iterm[:title]).first_or_create(description: law_iterm[:description], public: true)
end
