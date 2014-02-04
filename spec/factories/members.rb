# Read about factories at https://github.com/thoughtbot/factory_girl
include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :member do
    avatar { fixture_file_upload( File.join(Rails.root, "spec/fixtures/avatar.jpg"), "image/jpg" ) }
    name "Liyafei"
    title "SET"
    description "description"
  end
end
