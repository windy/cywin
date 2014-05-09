# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :logo do
    image { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'logo.png')) }
  end
end
