require 'rails_helper'

RSpec.describe Resource, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :workspace_id }

    it "should not be possible to create resource groups with the same name in a workspace" do
      create(:resource, name: "name 1")
      expect{
        create(:resource, name: "name 1")
      }.to raise_error(ActiveRecord::RecordInvalid)

      resource = build(:resource, name: "name 1")
      resource.valid?
      expect(resource.errors.include?(:name)).to be_truthy
    end

    it "should allow same name in different workspaces" do
      create(:resource, name: "name 1", workspace_id: 1)
      expect{
        create(:resource, name: "name 1", workspace_id: 2)
      }.not_to raise_error
    end

  end

  describe "Associations" do
    it { should belong_to(:workspace) }
  end
end
