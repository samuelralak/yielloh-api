class Quote < ActiveRecord::Base
	has_one :post, as: :postable, dependent: :destroy
	accepts_nested_attributes_for :post, allow_destroy: true
	
	validates :content, presence: true
end
