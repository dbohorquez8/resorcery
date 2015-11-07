FactoryGirl.define do
  factory :user do
    email
    password {'password'}

    trait :with_many_workspaces do
      after(:create) do |user|
        user.workspaces.push *(create_list :workspace, 4)
      end
    end
  end
end
