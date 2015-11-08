class GuestsController < ApplicationController
  def show
    @guest = User.find_by_email("guest@resorcery.co")
    sign_in @guest
    redirect_to dashboard_path
  end
end
