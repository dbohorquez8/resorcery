FactoryGirl.define do
  factory :resource_group do
    name         { Bazaar.super_object }
    workspace_id { 1 }

    factory :resource_group_with_workspace do
      workspace
    end
  end
end
