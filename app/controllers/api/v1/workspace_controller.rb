class Api::V1::WorkspaceController < ApiController
  version 1

  def index
    expose current_user.workspaces, each_serializer: WorkspaceSerializer
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
