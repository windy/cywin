# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :talk do
    target_type "MyString"
    target_id 1
    user_id 1
  end
end
