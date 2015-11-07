# this is the main controller for the API. It will handle everything related with the api
# for the time being it will be private
class ApiController < RocketPants::Base
  include Devise::Controllers::Helpers

  before_filter :authenticate_user!

end
