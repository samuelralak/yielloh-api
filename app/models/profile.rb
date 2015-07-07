class Profile < ActiveRecord::Base
	belongs_to :user

	validates :fullname, presence: true, :on => :update
	validates :username, presence: true, uniqueness: { case_sensitive: false }, :on => :update
	validates :user_id, presence: true, uniqueness: { message: "Profile already exists" }

end
