class PostSerializer < ActiveModel::Serializer
  attributes :id, :user, :postable, :comments, :url, :tag_list, :page, :postable_type

  has_one :user

  def url
  	if postable.class.name.eql?('Article')
  		api_article_post_url(postable, object, only_path: true)
  	elsif postable.class.name.eql?('Quote')
  		api_quote_post_url(postable, object, only_path: true)
  	else

  	end
  end
end
