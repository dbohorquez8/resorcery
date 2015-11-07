class ErrorsController < ApplicationController
  def not_found
    render :status => 404, layout: false
  end

  def unacceptable
    render :status => 422, layout: false
  end

  def internal_error
    render :status => 500, layout: false
  end
end
