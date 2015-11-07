class Api::V1::AllocationsController < ApiController
  include WorkspaceFinder

  version 1

  def create
    resource = @workspace.allocations.create(allocation_params)
    expose resource, serializer: AllocationSerializer
  end

  private
    def allocation_params
      params.require(:allocation).permit(:resource_id, :resource_group_id, :start_date, :end_date, metadata: [])
    end
end
