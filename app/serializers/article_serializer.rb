class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :media, :post

  has_one :post
end
