class User < ActiveRecord::Base
    rolify
    # acts_as_taggable # Alias for acts_as_taggable_on :tags
    acts_as_taggable_on :interests

    has_one :profile, dependent: :destroy, autosave: true
    has_one :oauth_admin_login, inverse_of: :user, dependent: :destroy

    has_many :pages, inverse_of: :user
    has_many :comments, dependent: :destroy
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
  		:recoverable, :rememberable, :trackable, :validatable

    accepts_nested_attributes_for :profile, allow_destroy: true

end
