class Api::V1::AvailabilitiesController < ApiController
  include WorkspaceFinder

  version 1

  # returns the availability of a given resource
  def show
    resource = @workspace.resources.find(params[:id])
    availability = resource.fetch_availability(start_date: Date.current)
    expose availability, metadata:{ server_message: "Availability fetched for #{resource.name.capitalize}"}
  end
end
