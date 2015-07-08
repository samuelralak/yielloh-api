class User < ActiveRecord::Base
    rolify

	has_one :profile, dependent: :destroy
	has_one :oauth_admin_login, inverse_of: :user, dependent: :destroy

	has_many :pages, inverse_of: :user
    has_many :comments, dependent: :destroy
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
  		:recoverable, :rememberable, :trackable, :validatable

    after_create :create_user_profile

    private
        def create_user_profile
            Profile.create(user_id: self.id)
        end
end
