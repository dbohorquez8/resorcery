class Api::V1::AllocationsController < ApiController
  include WorkspaceFinder

  version 1

  def create
    resource = @workspace.allocations.build(allocation_params)

    if resource.save
      expose resource, serializer: AllocationSerializer, metadata: { server_message: "#{@workspace.resources_name} allocated"}
    else
      creation_error resource.errors, { server_message: "There was a poblem with this allocation"}
    end
  end

  def index
    allocations = @workspace.allocations.where("start_date >= :start_date AND end_date <= :end_date",
                                               start_date: 3.days.ago,
                                               end_date: 4.days.from_now)
    expose allocations, serializer: AllocationSerializer
  end

  private
    def allocation_params
      params.require(:allocation).permit(:resource_id, :resource_group_id, :start_date, :end_date, metadata: [])
    end
end
