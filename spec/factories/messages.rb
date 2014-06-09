FactoryGirl.define do
  factory :message do
    action Message::LEADER_CONFIRM
    must_action false
  end

  factory :message_must_action, class: Message do
    action Message::LEADER_INVITE
    must_action true
  end

end
