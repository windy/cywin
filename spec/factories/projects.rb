# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "name"
    oneword "hello world"
    description "description"
    stage "开发中"
    where1 "where1"
    where2 "where2"
    logo File.open( File.join(Rails.root, "spec/fixtures/logo.png") )
  end
end
