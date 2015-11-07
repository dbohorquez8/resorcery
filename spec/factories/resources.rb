FactoryGirl.define do
  factory :resource do
    name         { Bazaar.super_object }
    workspace_id { 1 }

    factory :resource_with_workspace do
      workspace
    end

    trait :with_tag do
      tag_list { [Bazaar.super_object] }
    end
  end

end
