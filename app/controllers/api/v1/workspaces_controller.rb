class Api::V1::WorkspacesController < ApiController
  include ManageDefaultDates
  before_action :init_dates_range

  version 1

  def index
    expose current_user.workspaces.page(params[:page]).per(params[:per]), each_serializer: WorkspaceSerializer
  end

  def create
    workspace = current_user.workspaces.create(workspace_params)
    expose workspace, serializer: WorkspaceSerializer
  end

  def show
    workspace = current_user.workspaces.from_unique_id(workspace_id).includes(:resources, :resource_groups).first!
    serialized = WorkspaceSerializer.new(workspace).serializable_hash
    serialized[:allocations] = ActiveModel::ArraySerializer.new(workspace.allocations.in_range(@start_date, @end_date), each_serializer: AllocationSerializer).serializable_array
    expose(serialized)
  end

  private
    def workspace_params
      params.require(:workspace).permit(:name, metadata: [:resources_name, :resource_groups_name])
    end

    def workspace_id
      params.require(:wid)
    end
end
