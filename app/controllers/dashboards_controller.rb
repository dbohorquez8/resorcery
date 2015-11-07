class DashboardsController < ResorceryController

  def show
    @workspaces = current_user.workspaces
  end
end
