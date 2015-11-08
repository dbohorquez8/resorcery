class Api::V1::AvailabilitiesController < ApiController
  include WorkspaceFinder

  version 1

  # returns the availability of a given resource
  def show
    resource = @workspace.resources.find(params[:id])
    availability = resource.fetch_availability(start_date: get_start_date)
    expose availability, metadata:{ server_message: "Availability fetched for #{resource.name.capitalize}"}
  end

  def get_start_date
    begin
      date = params[:start_date].present? ? Date.parse(params[:start_date]) : Date.current
      date = Date.current if date < Date.current
    rescue => e
      Date.current
    end
  end
end
