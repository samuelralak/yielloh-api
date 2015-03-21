class Quote < ActiveRecord::Base
	has_many :posts, as: :postable
	
	validates :content, presence: true
end
