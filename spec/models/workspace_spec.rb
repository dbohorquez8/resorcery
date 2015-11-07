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
    let(:workspace) { build :workspace }

    it 'calls with_defaults' do
      expect(workspace).to receive(:with_defaults)
      workspace.save
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

  describe "with_defaults" do
    it "sets generated name if name not set" do
      workspace = build(:workspace, name: nil)

      expect(workspace.with_defaults).to eq(workspace)
      expect(workspace.name).not_to be_nil
    end

    it "doesn't set generated name if name already set" do
      workspace = build(:workspace, name: "Something Clever")

      expect(workspace.with_defaults).to eq(workspace)
      expect(workspace.name).to eq("Something Clever")
    end

    it "sets default metadata" do
      workspace = build(:workspace)

      expect(workspace.with_defaults).to eq(workspace)
      expect(workspace.metadata["resources_name"]).to eq(Workspace::DEFAULT_RESOURCES_NAME)
      expect(workspace.metadata["resource_groups_name"]).to eq(Workspace::DEFAULT_RESOURCE_GROUPS_NAME)
    end

    it "only sets unset metadata fields" do
      workspace = build(:workspace, metadata: {resources_name: "dreams"})

      expect(workspace.with_defaults).to eq(workspace)
      expect(workspace.metadata["resources_name"]).to eq("dreams")
      expect(workspace.metadata["resource_groups_name"]).to eq(Workspace::DEFAULT_RESOURCE_GROUPS_NAME)
    end
  end
end
