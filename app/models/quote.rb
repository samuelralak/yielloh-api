class Quote < ActiveRecord::Base
	has_one :post, as: :postable, dependent: :destroy
	accepts_nested_attributes_for :post, allow_destroy: true
	acts_as_commentable

	
	validates :content, presence: true

	attr_accessor :tags
end
