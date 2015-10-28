class Post < ActiveRecord::Base
	acts_as_taggable # Alias for acts_as_taggable_on :tags
	
	belongs_to :page, inverse_of: :posts
	belongs_to :postable, polymorphic: true

	accepts_nested_attributes_for :page, allow_destroy: true
	acts_as_commentable

	has_reputation :votes, source: :user, aggregated_by: :sum

	attr_accessor :tags
end
