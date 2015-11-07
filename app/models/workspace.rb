class Workspace < ActiveRecord::Base
  DEFAULT_RESOURCES_NAME = "resource".freeze
  DEFAULT_RESOURCE_GROUPS_NAME = "group".freeze

  validates :name, presence: true
  validates :user_id, presence: true

  has_many :resource_groups, foreign_key: :workspace_id, inverse_of: :workspace
  has_many :resources, foreign_key: :workspace_id, inverse_of: :workspace
  has_many :allocations, inverse_of: :workspace
  belongs_to :user, inverse_of: :workspaces

  before_validation :init_resource_name_and_group_name, on: :create
  before_validation :init_name_generator, on: :create

  scope :from_unique_id, -> (uid) { where(id: $hashids.decode(uid).first) }

  # this method returns a unique id for the workspace. This is so we can have unique urls
  def unique_id
    $hashids.encode(self.id)
  end

  private
  # this method sets the default resource name and resource group name for a worskpace.
  # remember the user is able to change this later
  def init_resource_name_and_group_name
    metadata[:resources_name]       = DEFAULT_RESOURCES_NAME
    metadata[:resource_groups_name] = DEFAULT_RESOURCE_GROUPS_NAME
  end

  # setups the name of the workspace if the user did not pass any
  def init_name_generator
    unless self.name.present?
      self.name = Bazaar.super_object
    end
  end
end
