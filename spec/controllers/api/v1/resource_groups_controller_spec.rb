require 'rails_helper'

RSpec.describe Api::V1::ResourceGroupsController, "Actions", type: :controller, test_type: :action do
  let(:workspace){ FactoryGirl.create(:workspace_with_user) }
  let(:user){ workspace.user }

  before do
    sign_in(user)
  end

  context "#create" do
    describe "endpoint exists" do
      before do
        post :create, api_params(wid: workspace.unique_id)
      end

      it { expect be_success }
    end

    describe "not sending the params" do
      it "should return error if a parameter is missing" do
        expect{
          post :create, api_params(resource: {name: "my worspace"})
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end

    describe "sending params" do
      it "should create a resource" do
        expect{
          post :create, api_params(wid: workspace.unique_id, resource_group: {name: "my worspace"})
        }.to change(ResourceGroup, :count).by(1)

        expect{
          post :create, api_params(wid: workspace.unique_id, resource_group: {name: "something"})
        }.to change(ResourceGroup, :count).by(1)
      end

      it "should return the newly created resource" do
        post :create, api_params(wid: workspace.unique_id, resource_group: {name: "something"})
        expect(json_response(response.body)[:id]).to eq(ResourceGroup.last.id)
      end

      it "should return the errors if the resources can not be created" do
        post :create, api_params(wid: workspace.unique_id, resource_group: {name: ""})
        expect(json_response(response.body)[:error]).not_to be_empty
      end
    end
  end
end
