class Profile < ActiveRecord::Base
	belongs_to :user

	validates :fullname, presence: true
	validates :username, presence: true, uniqueness: { case_sensitive: false }
	validates :user_id, presence: true, uniqueness: { message: "Profile already exists" }
end
