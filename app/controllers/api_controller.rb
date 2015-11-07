# this is the main controller for the API. It will handle everything related with the api
# for the time being it will be private
class ApiController < RocketPants::Base
  # this modules are required so doorkeeper plays nicely with rocketpants
  include ActionController::Head

  before_action :authenticate_user!

end