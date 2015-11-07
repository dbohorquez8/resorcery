class Workspace < ActiveRecord::Base
  DEFAULT_RESOURCES_NAME = "resource".freeze
  DEFAULT_RESOURCE_GROUPS_NAME = "group".freeze

  before_create :init_resource_name_and_group_name
  before_create :init_name_generator

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
