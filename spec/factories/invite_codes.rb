# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invite_code do
    code 1
    used false
  end
end
