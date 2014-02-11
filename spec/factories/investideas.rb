# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :investidea do
    type ""
    min 1
    max 1
    industry "MyString"
    idea "MyString"
    give "MyString"
  end
end
