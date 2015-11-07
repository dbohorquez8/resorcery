class AllocationSerializer < ActiveModel::Serializer
  attributes :id, :workspace_id, :resource_id, :resource_group_id, :start_date, :end_date, :metadata
end
