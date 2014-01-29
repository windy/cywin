# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :money_require do
    money "MyString"
    share "MyString"
    description "MyString"
  end
end
