class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :media, :post
end
