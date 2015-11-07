require 'rails_helper'

RSpec.describe ResourceGroup, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :workspace_id }

    it "should not be possible to create resource groups with the same name in a workspace" do
      create(:resource_group, name: "name 1")
      expect{
        create(:resource_group, name: "name 1")
      }.to raise_error(ActiveRecord::RecordInvalid)

      resource_group = build(:resource_group, name: "name 1")
      resource_group.valid?
      expect(resource_group.errors.include?(:name)).to be_truthy
    end

    it "should allow same name in different workspaces" do
      create(:resource_group, name: "name 1", workspace_id: 1)
      expect{
        create(:resource_group, name: "name 1", workspace_id: 2)
      }.not_to raise_error
    end

  end

  describe "Associations" do
    it { should belong_to(:workspace) }
    it { should have_many(:allocations).inverse_of(:resource_group) }
  end

end
