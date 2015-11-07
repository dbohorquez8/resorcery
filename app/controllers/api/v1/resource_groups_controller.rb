class Api::V1::ResourceGroupsController < ApiController
  include WorkspaceFinder

  version 1

  def create
    resource = @workspace.resource_groups.create(resource_group_params)
    expose resource, serializer: ResourceGroupSerializer
  end

  private
    def resource_group_params
      params.require(:resource_group).permit(:name, metadata: [])
    end
end
