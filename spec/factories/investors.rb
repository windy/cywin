# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :investor do
    user_id 1
    type ""
    name "MyString"
    phone "MyString"
    company "MyString"
    title "MyString"
    description "MyText"
  end
end
