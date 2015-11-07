class Api::V1::ResourceController < ApiController
  include WorkspaceFinder

  version 1

  def create
    resource = @workspace.resources.create(resource_params)
    expose resource, serializer: ResourceSerializer
  end

  private
    def resource_params
      params.require(:resource).permit(:name, metadata: [])
    end
end
