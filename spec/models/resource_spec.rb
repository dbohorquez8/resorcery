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
    it { should have_many(:allocations).inverse_of(:resource) }
  end

  describe "tag_list" do
    it "has items" do
      resource = create :resource, :with_tag
      expect(resource.tag_list.length).to eq(1)
    end
  end

  describe "availability" do
    before(:each) do
      @workspace = create(:workspace)
      @resource = create(:resource, name: "name 1", workspace_id: @workspace.id)
    end

    def format_date(date)
      date.strftime(Resource::PREFERRED_DATE_FORMAT)
    end

    # - - - - - - - - - - - -
    it "should return today - anytime soon when there are no allocations" do
      result = @resource.fetch_availability(start_date: Date.current).first
      expect(result[:start_date]).to eq(format_date(Date.current))
      expect(result[:end_date]).to eq("anytime")
    end

    # - - - - - - - - - - - -
    it "should return only one result when there are no allocations" do
      result = @resource.fetch_availability(start_date: Date.current)
      expect(result.count).to eq(1)
    end

    context 'if the user has one allocation' do
      # - - - - - [allocation] - - - - -
      it "should return today until the allocation start date" do
        allocation = create(:allocation_with_relations, resource: @resource, start_date: Date.current + 7.days, end_date: Date.current + 15.days)

        result = @resource.fetch_availability(start_date: Date.current).first
        expect(result[:start_date]).to eq(format_date(Date.current))
        expect(result[:end_date]).to eq(format_date(allocation.start_date - 1.day))
      end

      # [allocation] - - - - - -
      context 'if the allocation starts today' do
        it "should return one day after the first allocation until any time" do
          allocation = create(:allocation_with_relations, resource: @resource, start_date: Date.current, end_date: Date.current + 10.days)
          result = @resource.fetch_availability(start_date: Date.current).first
          expect(result[:start_date]).to eq(format_date(Date.current + 11.days))
          expect(result[:end_date]).to eq("anytime")
        end
      end

      # [allocation] - - - - - -
      context 'the allocation ends today' do
        it "should not consider the current date as a viable candidate because it will overlap with the end date of the previous allocation" do
          allocation = create(:allocation_with_relations, resource: @resource, start_date: Date.current - 4.days, end_date: Date.current)
          result = @resource.fetch_availability(start_date: Date.current).first
          expect(result[:start_date]).to eq(format_date(allocation.end_date + 1.days))
          expect(result[:end_date]).to eq("anytime")
        end
      end

      # [allocation] - - - - - -
      context 'the allocation ends some days after today' do
        it "should not consider the current date as a viable candidate because it will overlap with the end date of the previous allocation" do
          allocation = create(:allocation_with_relations, resource: @resource, start_date: Date.current - 4.days, end_date: Date.current + 4.days)
          result = @resource.fetch_availability(start_date: Date.current).first
          expect(result[:start_date]).to eq(format_date(allocation.end_date + 1.days))
          expect(result[:end_date]).to eq("anytime")
        end
      end

      context 'the allocation is one day only and tomorrow' do
        # - [allocation] - - - - - -
        it "should return a one day range" do
          allocation = create(:allocation_with_relations, resource: @resource, start_date: Date.current + 1.day, end_date: Date.current + 1.day)
          result = @resource.fetch_availability(start_date: Date.current).first
          expect(result[:start_date]).to eq(format_date(Date.current))
          expect(result[:end_date]).to eq(format_date(Date.current))
        end
      end
    end

    context 'more than one allocation' do
      context '2 of them' do
        before(:each) do
          @allocation1 = create(:allocation_with_relations, workspace: @workspace, resource: @resource, start_date: Date.current + 3.days, end_date: Date.current + 7.days)
          @allocation2 = create(:allocation_with_relations, workspace: @workspace, resource: @resource, start_date: Date.current + 10.days, end_date: Date.current + 13.days)
        end

        # - - - - [allocation] - - - -- - [allocation] - - -
        it "should return three allocations" do
          result = @resource.fetch_availability(start_date: Date.current)
          expect(result.size).to eq(3)
        end
        # - - - - [allocation] - - - -- - [allocation] - - -
        it "should return non overlaping ranges" do
          result = @resource.fetch_availability(start_date: Date.current)

          expect(result[0][:start_date]).to eq(format_date(Date.current))
          expect(result[0][:end_date]).to eq(format_date(@allocation1.start_date - 1.day))

          expect(result[1][:start_date]).to eq(format_date(@allocation1.end_date + 1.day))
          expect(result[1][:end_date]).to eq(format_date(@allocation2.start_date - 1.day))

          expect(result[2][:start_date]).to eq(format_date(@allocation2.end_date + 1.day))
          expect(result[2][:end_date]).to eq("anytime")
        end

        context 'no spaces between them' do
          before(:each) do
            Allocation.destroy_all
            @allocation1 = create(:allocation_with_relations, workspace: @workspace, resource: @resource, start_date: Date.current + 3.days, end_date: Date.current + 7.days)
            @allocation2 = create(:allocation_with_relations, workspace: @workspace, resource: @resource, start_date: Date.current + 8.days, end_date: Date.current + 13.days)
          end

          # - - - - [allocation][allocation] - - -
          it "should return two allocations" do
            result = @resource.fetch_availability(start_date: Date.current)
            expect(result.size).to eq(2)
          end

          # - - - - [allocation][allocation] - - -
          it "should ignore allocations that have no espaces between them" do
            result = @resource.fetch_availability(start_date: Date.current)

            expect(result[0][:start_date]).to eq(format_date(Date.current))
            expect(result[0][:end_date]).to eq(format_date(@allocation1.start_date - 1.day))

            expect(result[1][:start_date]).to eq(format_date(@allocation2.end_date + 1.day))
            expect(result[1][:end_date]).to eq('anytime')
          end
        end

      end
    end
  end
end
