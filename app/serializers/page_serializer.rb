class PageSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :cover, :posts, :user
end
