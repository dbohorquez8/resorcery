class WorkspacesController < ApplicationController
  before_action :load_workspace, only: [:show]

  def show
  end

  def new
    @workspace = Workspace.new.with_defaults
  end

  private
    def load_workspace
      @workspace = Workspace.from_unique_id(params[:wid]).first!
    end
end
