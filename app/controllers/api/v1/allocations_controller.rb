class Api::V1::AllocationsController < ApiController
  include WorkspaceFinder

  version 1

  def create
    resource = @workspace.allocations.build(allocation_params)

    if resource.save
      expose resource, serializer: AllocationSerializer
    else
      creation_error resource.errors
    end
  end

  private
    def allocation_params
      params.require(:allocation).permit(:resource_id, :resource_group_id, :start_date, :end_date, metadata: [])
    end
end
