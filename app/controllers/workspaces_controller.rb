class WorkspacesController < ApplicationController
  before_filter :workspace, only: [:show, :destroy]

  def index
    @workspaces = Workspace.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workspaces, each_serializer: WorkspaceSerializer }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workspace, serializer: WorkspaceSerializer }
    end
  end

  def create
    @workspace = Workspace.create(workspace_params)
    render json: @workspace, serializer: WorkspaceSerializer, status: :created
  end

  def destroy
    @workspace.destroy
    head :no_content
  end

  private
    def workspace
      @workspace ||= Workspace.find(params[:id])
    end

    def workspace_params
      params.require(:workspace).permit(:name, metadata: [])
    end
end
