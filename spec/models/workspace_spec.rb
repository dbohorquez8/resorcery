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
    it { should have_many(:resources).class_name('Resource').with_foreign_key("workspace_id") }
    it { should have_many(:allocations).inverse_of(:workspace) }
    it { should belong_to(:user).inverse_of(:workspaces) }
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

    it "should not change the name after update" do
      workspace = create(:workspace, name: 'Something Clever')
      workspace.metadata[:algo] = "algo"
      workspace.save
      expect(workspace.reload.name).to eq('Something Clever')
    end
  end

  describe "querying using unique id" do
    it "should encode the workspace id" do
      workspace = create(:workspace, name: 'Something Clever')
      expect(workspace.unique_id).not_to eq(workspace.id)
    end

    it "should be able to find workspaces via the unique id" do
      workspace = create(:workspace)
      create(:workspace)
      create(:workspace)
      create(:workspace)
      expect(Workspace.from_unique_id(workspace.unique_id).first.id).to eq(workspace.id)
    end
  end

end
