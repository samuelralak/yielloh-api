class PageSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :posts
end