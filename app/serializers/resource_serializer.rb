class ResourceSerializer < ActiveModel::Serializer
  attributes :id, :name, :metadata, :tag_list
end
