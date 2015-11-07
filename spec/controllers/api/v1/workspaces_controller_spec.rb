require 'rails_helper'

RSpec.describe Api::V1::WorkspacesController, "Actions", type: :controller, test_type: :action do
  let(:user){ FactoryGirl.create(:user) }

  before do
    sign_in(user)
  end

  context "#create" do
    describe "endpoint exists" do
      before do
        post :create, api_params
      end

      it { expect be_success }
    end

    describe "sending params" do
      it "should create a workspace" do
        expect{
          post :create, api_params(workspace: {name: "my worspace"})
        }.to change(Workspace, :count).by(1)

        expect{
          post :create, api_params(workspace: {name: ""})
        }.to change(Workspace, :count).by(1)
      end

      it "should return the newly created workspace" do
        post :create, api_params(workspace: {name: ""})
        expect(json_response(response.body)[:unique_id]).to eq(Workspace.last.unique_id)
      end
    end
  end

  context '#index' do
    describe "endpoint exists" do
      before do
        get :index, api_params
      end

      it { expect be_success }
      it { expect be_collection_resource }
    end
  end

end
