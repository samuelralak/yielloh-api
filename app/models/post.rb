class Post < ActiveRecord::Base
	belongs_to :postable, polymorphic: true 	
	acts_as_commentable

	has_reputation :votes, source: :user, aggregated_by: :sum
end
