# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :money_require do
    money 10000
    share 10
    deadline 60
    description "第一轮融资需求"
  end
end
