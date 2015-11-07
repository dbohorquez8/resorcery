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

  end

  describe "Associations" do
    it { should belong_to(:workspace) }
  end

end
