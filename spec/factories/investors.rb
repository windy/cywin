# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :investor do
    user_id 1
    investor_type Investor::PERSON
    name "投资人名字"
    phone "15911112222"
    company "company"
    title "CTO"
    description "爱好者"
    card { fixture_file_upload( File.join(Rails.root, "spec/fixtures/logo.png"), "image/png" ) }

    trait :applied do
      status 'applied'
    end
    trait :passed do
      status 'passed'
    end
    
    trait :rejected do
      status 'rejected'
    end

    factory :investor_applied, traits: [:applied]
    factory :investor_passed, traits: [:passed]
    factory :investor_rejected, traits: [:rejected]
  end
end
