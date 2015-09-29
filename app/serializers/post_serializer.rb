class PostSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :postable, :comments, :url, :tag_list

  def url
  	if postable.class.name.eql?('Article')
  		api_article_post_url(postable, object, only_path: true)
  	elsif postable.class.name.eql?('Quote')
  		api_quote_post_url(postable, object, only_path: true)
  	else

  	end
  end
end
