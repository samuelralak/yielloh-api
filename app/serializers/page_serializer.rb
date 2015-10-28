class PageSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :cover, :user
end
