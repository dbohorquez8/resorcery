require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "#GET index" do
    let(:perform) { sign_in(user) and get :index }
    let(:user) { create :user }

    context "with a single workspace" do
      let(:workspace) { user.workspaces.first }
      before { perform }

      it { expect(response).to redirect_to(workspace_path(wid: workspace.unique_id, name: workspace.name.parameterize)) }
    end

    context "with many workspaces" do
      let(:user) { create :user, :with_many_workspaces }
      before { perform }

      it { expect(response).to redirect_to(dashboard_path) }
    end
  end
end
