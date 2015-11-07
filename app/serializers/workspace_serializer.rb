class WorkspaceSerializer < ActiveModel::Serializer
  attributes :name, :unique_id, :metadata, :location

  has_many :resources
  has_many :resource_groups, as: :children
  has_many :allocations

 def location
   Rails.application.routes.url_helpers.workspace_path(wid: unique_id, name: name.parameterize)
 end

end
