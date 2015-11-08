require 'rails_helper'

RSpec.describe Api::V1::ResourcesController, "Actions", type: :controller, test_type: :action do
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
          post :create, api_params(wid: workspace.unique_id, resource: {name: "my worspace"})
        }.to change(Resource, :count).by(1)

        expect{
          post :create, api_params(wid: workspace.unique_id, resource: {name: "something"})
        }.to change(Resource, :count).by(1)
      end

      it "should return the newly created resource" do
        post :create, api_params(wid: workspace.unique_id, resource: {name: "something", tag_list: ["test"]})
        parsed_body = json_response(response.body)
        expect(parsed_body[:id]).to eq(Resource.last.id)
      end

      it "should return the errors if the resources can not be created" do
        post :create, api_params(wid: workspace.unique_id, resource: {name: ""})
        expect(json_response(response.body)[:error]).not_to be_empty
      end
    end
  end
end
