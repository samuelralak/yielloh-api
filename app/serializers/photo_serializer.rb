class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :caption, :image, :post
end
