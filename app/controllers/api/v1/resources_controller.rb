class Api::V1::ResourcesController < ApiController
  include WorkspaceFinder

  version 1

  def create
    resource = @workspace.resources.build(resource_params)

    if resource.save
      expose resource, serializer: ResourceSerializer
    else
      creation_error resource.errors
    end
  end

  private
    def resource_params
      params.require(:resource).permit(:name, tag_list: [], metadata: [])
    end
end
