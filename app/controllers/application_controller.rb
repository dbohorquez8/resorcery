class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def not_found
      head :not_found
    end
end
