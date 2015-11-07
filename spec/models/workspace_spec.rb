require 'rails_helper'

RSpec.describe Workspace ,type: :model do
  describe "Validations" do
  end

  describe "before_create" do
    before(:each) do
      @workspace = create(:workspace, name: '')
    end

    it "should setup the resources name" do
      expect(@workspace.metadata[:resources_name]).to eq(Workspace::DEFAULT_RESOURCES_NAME)
    end

    it "should set the resource groups name" do
      expect(@workspace.metadata[:resource_groups_name]).to eq(Workspace::DEFAULT_RESOURCE_GROUPS_NAME)
    end

    it "should generate a random name if I do not pass a name" do
      expect(@workspace.name).not_to be_nil
    end

    it "should not setup the random name if I pass the name" do
      workspace = create(:workspace, name: 'Something Clever')
      expect(workspace.name).to eq('Something Clever')
    end

  end

end
