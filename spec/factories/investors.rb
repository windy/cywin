# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :investor do
    investor_type Investor::PERSON
    phone "15911112222"
    company "company"
    title "CTO"

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
