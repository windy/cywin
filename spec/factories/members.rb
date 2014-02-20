# Read about factories at https://github.com/thoughtbot/factory_girl
include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :member do
    title "CTO"
    role "创始人"
    priv "owner"
    description "description"
  end
end
