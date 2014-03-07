# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :investment do
    name "MyString"
    address "MyString"
    description "MyText"
    investor_id 1
  end

  factory :investment_for_money, class: Investment do
    money 10
  end
end
