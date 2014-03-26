FactoryGirl.define do
  factory :user do
    name "tester"
    email "tester@cywin.cn"
    password "12345678"
    password_confirmation "12345678"
  end

  factory :zhang, class: :User do
    name "zhang"
    email "zhang@cywin.cn"
    password "12345678"
    password_confirmation "12345678"
  end

  factory :investor_user, class: :User do
    name "investor_user"
    email "investor_user@cywin.cn"
    password "12345678"
    password_confirmation "12345678"
  end
end

