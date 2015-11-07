class Api::V1::ResourceGroupsController < ApiController
  include WorkspaceFinder

  version 1

  def create
    resource = @workspace.resource_groups.build(resource_group_params)

    if resource.save
      expose resource, serializer: ResourceGroupSerializer
    else
      creation_error resource.errors
    end
  end

  private
    def resource_group_params
      params.require(:resource_group).permit(:name, metadata: [])
    end
end
