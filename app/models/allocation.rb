class Allocation < ActiveRecord::Base
  validates :workspace_id, presence: true
  validates :resource_id, presence: true
  validates :resource_group_id, presence: true

  # date validations.
  # when creating an allocation, we want to validate:
  # => a user must provide a start_date
  # => the end_date must be after or equal the start_date
  validates :start_date, date: { allow_blank: false}
  validates :end_date, date: { after_or_equal_to: :start_date }
  validate :non_overlapping_allocation

  belongs_to :resource,       class_name: "Resource", foreign_key: :resource_id, inverse_of: :allocations
  belongs_to :resource_group, class_name: "ResourceGroup", foreign_key: :resource_group_id, inverse_of: :allocations
  belongs_to :workspace,      class_name: "Workspace", foreign_key: :workspace_id, inverse_of: :allocations

  scope :for_workspace,      -> (workspace) { where(workspace_id: workspace) }
  scope :for_resource,       -> (resource) { where(resource_id: resource) }
  scope :for_resource_group, -> (resource_group) { where(resource_group_id: resource_group) }
  scope :in_range, -> (start_date, end_date) { where("start_date >= :start_date AND end_date <= :end_date", start_date: start_date, end_date: end_date) }

  private

  # this method will check that this allocation is not overlapping.
  # the criteria to decide if an allocation is overlapping are:
  # => There exist no allocation for the resource, resource group and workspace where
  #    the date ranges overlap
  def non_overlapping_allocation
    if Allocation.for_workspace(self.workspace_id)
        .for_resource(self.resource_id)
        .for_resource_group(self.resource_group_id)
        .where("end_date >= ?", self.start_date).any?
      self.errors.add(:start_date, "must not overlap with existing allocations")
      return false
    end
  end


end
