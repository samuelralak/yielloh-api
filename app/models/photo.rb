class Photo < ActiveRecord::Base
	has_one :post, as: :postable, dependent: :destroy
	accepts_nested_attributes_for :post, allow_destroy: true

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  	validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/jpeg", "image/gif", "image/png"] }

  	validates :image, presence: true
end
