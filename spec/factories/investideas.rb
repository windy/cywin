# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :investidea do
    coin_type Investidea::COIN_TYPE[0]
    min 1
    max 100
    industry "MyString"
    idea "MyString"
    give "MyString"
  end
end
