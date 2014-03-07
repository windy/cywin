# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :money_require do
    money 100
    share 10
    deadline { 10.days.since(Time.now).to_datetime }
    description "第一轮融资需求"
  end
end
