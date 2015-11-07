class Api::V1::ResourcesController < ApiController
  include WorkspaceFinder

  version 1

  def create
    resource = @workspace.resources.build(resource_params)

    if resource.save
      expose resource, serializer: ResourceSerializer, metadata:{ server_message: "#{@workspace.resources_name} created!"}
    else
      creation_error resource.errors, { server_message: "There was a problem creating the #{@workspace.resources_name}."}
    end
  end

  private
    def resource_params
      params.require(:resource).permit(:name, tag_list: [], metadata: [])
    end
end
