require 'rails_helper'

RSpec.describe Api::V1::AllocationsController, "Actions", type: :controller, test_type: :action do

  def allocation_attributes(options = {})
    {resource_id: resource.id, resource_group_id: resource_group.id, start_date: Date.current, end_date: Date.current}.merge(options)
  end

  let(:workspace){ FactoryGirl.create(:workspace_with_user) }
  let(:resource){ FactoryGirl.create(:resource, workspace_id: workspace.id) }
  let(:resource_group){ FactoryGirl.create(:resource_group, workspace_id: workspace.id) }
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
          post :create, api_params(allocation: {name: "my worspace"})
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end

    describe "sending params" do
      it "should create a allocation" do
        expect{
          post :create, api_params(wid: workspace.unique_id, allocation: allocation_attributes)
        }.to change(Allocation, :count).by(1)
      end

      it "should not create the allocation if they overlap" do
        expect{
          post :create, api_params(wid: workspace.unique_id, allocation: allocation_attributes(start_date: Date.current - 5.days))
        }.to change(Allocation, :count).by(1)

        expect{
          post :create, api_params(wid: workspace.unique_id, allocation: allocation_attributes(start_date: Date.current - 3.days))
        }.to change(Allocation, :count).by(0)
      end

      it "should return overlap error" do
        create(:allocation, allocation_attributes(start_date: Date.current - 5.days, workspace_id: workspace.id))
        post :create, api_params(wid: workspace.unique_id, allocation: allocation_attributes(start_date: Date.current - 3.days))
        expect(json_response(response.body)[:error]).not_to be_empty
        expect(json_response(response.body)[:messages][:start_date]).to eq(["must not overlap with existing allocations"])
      end

      it "should return the newly created allocation" do
        post :create, api_params(wid: workspace.unique_id, allocation: allocation_attributes)
        expect(json_response(response.body)[:id]).to eq(Allocation.last.id)
      end

      it "should return the errors if the allocations can not be created" do
        post :create, api_params(wid: workspace.unique_id, allocation: {name: ""})
        expect(json_response(response.body)[:error]).not_to be_empty
      end

      it "must allow me to create allocations on the same date on different groups" do
        create(:allocation, allocation_attributes(workspace_id: workspace.id))
        expect{
          post :create, api_params(wid: workspace.unique_id, allocation: allocation_attributes(resource_group_id: 2))
          post :create, api_params(wid: workspace.unique_id, allocation: allocation_attributes(resource_group_id: 3))
          post :create, api_params(wid: workspace.unique_id, allocation: allocation_attributes(resource_group_id: 4))
        }.to change(Allocation, :count).by(3)

      end
    end
  end

end
