class WorkspaceSerializer < ActiveModel::Serializer
  attributes :name, :unique_id, :metadata, :location, :background_color, :resources_count, :resource_groups_count

  has_many :resources
  has_many :resource_groups, as: :children

  def location
    Rails.application.routes.url_helpers.workspace_path(wid: unique_id, name: name.parameterize)
  end

  def background_color
    object.metadata['background_color']
  end
end
