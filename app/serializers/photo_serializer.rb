class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :caption, :image, :post

  has_one :post
end
