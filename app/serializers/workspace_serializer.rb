class WorkspaceSerializer < ActiveModel::Serializer
  attributes :name, :unique_id, :metadata
end
