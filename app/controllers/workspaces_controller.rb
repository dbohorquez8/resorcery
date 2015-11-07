class WorkspacesController < ApplicationController
  before_action :load_workspace, only: [:show]

  def show
  end

  private
    def load_workspace
      @workspace = current_user.workspaces.from_unique_id(params[:wid]).first!
    end
end
