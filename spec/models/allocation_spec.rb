require 'rails_helper'

RSpec.describe Allocation, type: :model do
  describe "Validations" do
    it { is_expected.to validate_presence_of :workspace_id }
    it { is_expected.to validate_presence_of :resource_id }
    it { is_expected.to validate_presence_of :resource_group_id }

    context 'date validations' do
      it "should validate the start_date" do
        allocation = build(:allocation_with_relations, start_date: nil)
        expect(allocation.valid?).to be_falsy
        expect(allocation.errors.include?(:start_date)).to be_truthy
      end

      it "should validate end_date is higher than start_date" do
        allocation = build(:allocation_with_relations, end_date: Date.current - 10.days)
        expect(allocation.valid?).to be_falsy
        expect(allocation.errors.include?(:end_date)).to be_truthy
      end
    end

    context 'validating non overlapping allocations' do
      # this is so we can check that a resource can not be allocated on the same
      # resource group with overlapping date ranges
      it "should validate that allocations can not be overlaped" do
        allocation_1 = create(:allocation_with_relations, start_date: Date.current + 1.days, end_date: Date.current + 5.days)
        allocation_2 = build(:allocation, workspace_id: allocation_1.workspace_id, resource_id: allocation_1.resource_id, resource_group_id: allocation_1.resource_group_id, start_date: Date.current + 3.days, end_date: Date.current + 5.days)
        expect(allocation_2.valid?).to be_falsy
      end

      it "should let me create allocations in different resource groups overlapping" do
        allocation_1 = create(:allocation_with_relations, start_date: Date.current + 1.days, end_date: Date.current + 5.days)
        allocation_2 = build(:allocation, start_date: Date.current + 3.days, end_date: Date.current + 5.days)
        expect(allocation_2.valid?).to be_truthy
      end
    end
  end

  describe "Associations" do
    it { should belong_to(:resource) }
    it { should belong_to(:resource_group) }
    it { should belong_to(:workspace) }
  end
end
