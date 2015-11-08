class AddCounterCachesToWorkspace < ActiveRecord::Migration
  def self.up
    add_column :workspaces, :resources_count, :integer, :null => false, :default => 0
    add_column :workspaces, :resource_groups_count, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :workspaces, :resources_count
    remove_column :workspaces, :resource_groups_count
  end
end
