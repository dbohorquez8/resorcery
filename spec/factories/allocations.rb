FactoryGirl.define do
  factory :allocation do
    start_date        { Date.current + 5.days }
    end_date          { Date.current + 15.days }
    workspace_id      1
    resource_id       1
    resource_group_id 1

    factory :allocation_with_relations do
      workspace
      resource
      resource_group
    end
  end

end
