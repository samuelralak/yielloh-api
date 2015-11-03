class PageSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :cover, :user, :created_at, :updated_at

  has_one :user
end
