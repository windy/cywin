# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :investor do
    user_id 1
    investor_type Investor::PERSON
    name "MyString"
    phone "MyString"
    company "MyString"
    title "MyString"
    description "MyText"
  end
end
