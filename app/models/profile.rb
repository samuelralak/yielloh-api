class Profile < ActiveRecord::Base
	belongs_to :user

	validates :fullname, presence: true, :on => :update
	validates :username, presence: true, uniqueness: { case_sensitive: false }, :on => :update
	# validates :user_id, presence: true, uniqueness: { message: "Profile already exists" }

	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/default-avatar.png"
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
