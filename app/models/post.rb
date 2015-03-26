class Post < ActiveRecord::Base
	belongs_to :postable, polymorphic: true 	
	acts_as_commentable
end
