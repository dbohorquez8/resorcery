require 'rails_helper'

RSpec.describe Workspace ,type: :model do
  describe "Validations" do
    it "should validate name" do
      allow_any_instance_of(Workspace).to receive(:init_name_generator).and_return(true)
      expect(build(:workspace, name: '').valid?).to be_falsy
    end
  end

  describe "Associations" do
    it { should have_many(:resource_groups).class_name('ResourceGroup').with_foreign_key("workspace_id") }
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
