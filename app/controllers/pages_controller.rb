class PagesController < ApplicationController
  before_action :redirect_signed_in_users, only: [:index]
  layout "landing", only: [:index]

  def index
  end

  protected

  def redirect_signed_in_users
    return unless user_signed_in?

    redirect_to_workspace and return if current_user.workspaces.one?
    redirect_to dashboard_path
  end

  def redirect_to_workspace
    workspace = current_user.workspaces.first
    redirect_to workspace_path(wid: workspace.unique_id, name: workspace.name.parameterize)
  end
end
