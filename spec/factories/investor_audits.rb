# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :investor_audit, :class => 'InvestorAudits' do
    investor_id 1
    status "MyString"
    note "MyText"
  end
end
