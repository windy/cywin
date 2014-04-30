# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    user_id 1
    action "MyString"
    project_id 1
    must_action false
    status "MyString"
    target_type "MyString"
    target_id 1
  end
end
