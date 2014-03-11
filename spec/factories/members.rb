# Read about factories at https://github.com/thoughtbot/factory_girl
include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :member do
    title "CTO"
    role Member::FOUNDER
    priv "owner"
    description "description"
  end
end
