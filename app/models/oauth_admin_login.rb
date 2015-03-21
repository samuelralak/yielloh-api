class OauthAdminLogin < ActiveRecord::Base
	belongs_to :user, inverse_of: :oauth_admin_login
	before_validation(on: :create) do
		generate_access_token
	end
	# after_create :generate_access_token

	validates :user_id, presence: true
	validates :access_token, presence: true, uniqueness: true

	private
		def generate_access_token
			self.access_token = SecureRandom.hex
			self.is_logged_in = true
		end
end
