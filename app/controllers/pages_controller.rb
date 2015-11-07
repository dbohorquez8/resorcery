class PagesController < ApplicationController
  before_action :redirect_signed_in_users, only: [:index]

  def index
  end

  protected

  def redirect_signed_in_users
    redirect_to dashboard_path if user_signed_in?
  end
end
