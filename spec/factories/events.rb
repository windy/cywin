# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    target_type "MyString"
    target_id 1
    title "MyString"
    data "MyText"
    project_id 1
    action 1
    user_id 1
  end
end
