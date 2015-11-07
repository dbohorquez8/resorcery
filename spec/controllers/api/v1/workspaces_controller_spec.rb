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
        post :create, api_params(workspace: {name: "", metadata: {resources_name: 'dreams', weird_field: 'bah'}})
        parsed_body = json_response(response.body)

        expect(parsed_body[:unique_id]).to eq(Workspace.last.unique_id)
        expect(parsed_body[:metadata][:resources_name]).to eq('dreams')
        expect(parsed_body[:metadata]).not_to have_key(:weird_field)
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

    describe "sending params" do
      it "returns the list of paginated workspaces" do
        get :index, api_params
        expect(json_pagination(response.body)).not_to be_empty
      end
    end
  end

  context '#show' do
    let(:workspace) { FactoryGirl.create(:workspace) }

    describe "endpoint exists" do
      before do
        get :show, api_params(wid: workspace.to_param)
      end

      it { expect be_success }
      it { expect be_collection_resource }
    end

    describe "sending params" do

      it "returns a serialized workspace" do
        get :show, api_params(wid: workspace.to_param)
        expect(response.body).not_to be_empty
      end
    end
  end
end
