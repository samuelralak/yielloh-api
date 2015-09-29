class Article < ActiveRecord::Base
	has_one :post, as: :postable, dependent: :destroy
	accepts_nested_attributes_for :post, allow_destroy: true
	
	has_attached_file :media, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  	validates_attachment :media, :content_type => { :content_type => ["image/jpeg", "image/jpeg", "image/gif", "image/png"] }

  	validates :title, :content, presence: true

  	attr_accessor :tags
end
