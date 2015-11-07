class Resource < ActiveRecord::Base
  include Colorizable
  acts_as_taggable

  validates :workspace_id, presence: true
  validates :name, presence: true
  validates :name, uniqueness: {scope: :workspace_id}

  belongs_to :workspace, class_name: "Workspace", foreign_key: :workspace_id, inverse_of: :resources
  has_many :allocations, inverse_of: :resource
end
