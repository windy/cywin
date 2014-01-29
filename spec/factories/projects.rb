# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "name"
    oneword "hello world"
    description "description"
    stage "开发中"
    where1 "where1"
    where2 "where2"
    logo File.open( File.join(Rails.root, "spec/fixtures/logo.png") )
    contact
  end

  factory :shenzhen_project, class: :Project do
    name "shenzhen"
    oneword "shenzhen project test"
    description "description"
    stage "开发中"
    where1 "广东"
    where2 "深圳"
    logo File.open( File.join(Rails.root, "spec/fixtures/logo.png") )
  end

  factory :shenzhen_project2, class: :Project do
    name "shenzhen2"
    oneword "shenzhen2 project test"
    description "description"
    stage "开发中"
    where1 "广东"
    where2 "深圳"
    logo File.open( File.join(Rails.root, "spec/fixtures/logo.png") )
  end

  factory :project_with_member, parent: :project do
    members { create(:member) }
  end
end

