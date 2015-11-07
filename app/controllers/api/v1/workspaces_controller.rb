class Api::V1::WorkspacesController < ApiController
  version 1

  def index
    expose current_user.workspaces.page(params[:page]).per(params[:per]), each_serializer: WorkspaceSerializer
  end

  def create
    workspace = current_user.workspaces.create(workspace_params)
    expose workspace, serializer: WorkspaceSerializer
  end

  private
    def workspace_params
      params.require(:workspace).permit(:name, metadata: [])
    end
end
