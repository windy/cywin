# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "name"
    oneword "hello world"
    description "description"
  end

  factory :shenzhen_project, class: :Project do
    name "shenzhen"
    oneword "shenzhen project test"
    description "description"
  end

  factory :shenzhen_project2, class: :Project do
    name "shenzhen2"
    oneword "shenzhen2 project test"
    description "description"
  end

  factory :project_with_member, parent: :project do
    members { create(:member) }
  end
end

