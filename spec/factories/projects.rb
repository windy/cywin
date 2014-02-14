# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "name"
    oneword "hello world"
    description "description"
    stage "开发中"
    where1 "110000"
    where2 "110100"
    where3 "110101"
    logo { fixture_file_upload( File.join(Rails.root, "spec/fixtures/logo.png"), "image/png" ) }
    contact
    user_id 1
  end

  factory :shenzhen_project, class: :Project do
    name "shenzhen"
    oneword "shenzhen project test"
    description "description"
    stage "开发中"
    where1 "440000"
    where2 "440300"
    where3 "440303"
    logo { fixture_file_upload( File.join(Rails.root, "spec/fixtures/logo.png"), "image/png" ) }
    contact
    user_id 1
  end

  factory :shenzhen_project2, class: :Project do
    name "shenzhen2"
    oneword "shenzhen2 project test"
    description "description"
    stage "开发中"
    where1 "440000"
    where2 "440300"
    where3 "440303"
    logo { fixture_file_upload( File.join(Rails.root, "spec/fixtures/logo.png"), "image/png" ) }
    contact
    user_id 1
  end

  factory :project_with_member, parent: :project do
    members { create(:member) }
  end
end

