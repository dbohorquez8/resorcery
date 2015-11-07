class Api::V1::ResourceGroupsController < ApiController
  include WorkspaceFinder

  version 1

  def create
    resource = @workspace.resource_groups.build(resource_group_params)

    if resource.save
      expose resource, serializer: ResourceGroupSerializer, metadata:{ server_message: "#{@workspace.resource_groups_name} created!"}
    else
      creation_error resource.errors, { server_message: "There was a problem creating the #{@workspace.resource_groups_name}."}
    end
  end

  private
    def resource_group_params
      params.require(:resource_group).permit(:name, metadata: [])
    end
end
