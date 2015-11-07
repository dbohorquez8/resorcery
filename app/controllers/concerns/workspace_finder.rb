module WorkspaceFinder
  extend ActiveSupport::Concern

  included do
    attr_reader :workspace
    before_filter :load_workspace
  end

  def load_workspace
    @workspace = current_user.workspaces.from_unique_id(params[:wid]).first!
  end
end
