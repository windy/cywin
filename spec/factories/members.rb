# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    avatar File.open( File.join(Rails.root, "spec/fixtures/avatar.jpg") )
    name "Liyafei"
    title "SET"
    description "description"
  end
end
