class QuoteSerializer < ActiveModel::Serializer
  attributes :id, :content, :post

  has_one :post
end
