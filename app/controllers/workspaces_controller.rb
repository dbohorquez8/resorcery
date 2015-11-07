class WorkspacesController < ApplicationController
  before_filter :workspace, only: [:show, :destroy]

  def index
    @workspaces = Workspace.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    head :no_content
  end

  def destroy
    @workspace.destroy
    head :no_content
  end

  private
    def workspace
      @workspace ||= Workspace.find(params[:id])
    end
end
