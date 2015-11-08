class Api::V1::WorkspacesController < ApiController
  include ManageDefaultDates
  before_action :init_dates_range

  version 1

  def index
    expose current_user.workspaces.page(params[:page]).per(params[:per]), each_serializer: WorkspaceSerializer
  end

  def create
    workspace = current_user.workspaces.create(workspace_params)
    expose workspace, serializer: WorkspaceSerializer, metadata:{ server_message: "Workspace created!"}
  end

  def show
    workspace = current_user.workspaces.from_unique_id(workspace_id).includes(:resources, :resource_groups).first!
    serialized = WorkspaceSerializer.new(workspace).serializable_hash
    serialized[:allocations] = ActiveModel::ArraySerializer.new(workspace.allocations.in_range(@start_date, @end_date), each_serializer: AllocationSerializer).serializable_array
    expose serialized, metadata: calculate_statistics(serialized)
  end

  private
    def calculate_statistics(workspace)
      allocated_resources = workspace[:allocations].map{|r| r[:resource_id]}.uniq.count
      allocated_groups = workspace[:allocations].map{|r| r[:resource_group_id]}.uniq

      groups_without_allocations = (workspace[:resource_groups].map{|r| r[:id]} - allocated_groups).count

      total_resources = workspace[:resources].count
      {
        estatistics: {
          percentage_of_resources_allocated: total_resources > 0 ? (allocated_resources*100)/total_resources : 0,
          allocated_resources: allocated_resources,
          total_resources: total_resources,
          groups_without_allocations: groups_without_allocations
        }
      }
    end

    def workspace_params
      params.require(:workspace).permit(:name, metadata: [:resources_name, :resource_groups_name])
    end

    def workspace_id
      params.require(:wid)
    end
end
