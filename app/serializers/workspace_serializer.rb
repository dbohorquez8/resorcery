class WorkspaceSerializer < ActiveModel::Serializer
  attributes :name, :unique_id, :metadata, :location

  def location
    Rails.application.routes.url_helpers.workspace_path(wid: unique_id, name: name.parameterize)
  end
end
