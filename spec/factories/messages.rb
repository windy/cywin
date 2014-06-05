# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    action Message::LEADER_CONFIRM
    must_action false
  end
end
