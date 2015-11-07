require 'rails_helper'

RSpec.describe WorkspacesController, type: :controller do
  describe "#GET new" do
    it "assigns new workspace" do
      get :new
      expect(assigns(:workspace)).not_to be_nil
    end
  end
end
