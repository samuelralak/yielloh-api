class User < ActiveRecord::Base
  rolify
	has_one :profile, dependent: :destroy
	has_one :oauth_admin_login, inverse_of: :user, dependent: :destroy
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
  		:recoverable, :rememberable, :trackable, :validatable
end
