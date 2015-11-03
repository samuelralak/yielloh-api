class User < ActiveRecord::Base
    rolify
    # acts_as_taggable # Alias for acts_as_taggable_on :tags
    acts_as_taggable_on :interests

    has_one :profile, dependent: :destroy, autosave: true
    has_one :oauth_admin_login, inverse_of: :user, dependent: :destroy

    has_many :pages, inverse_of: :user
    has_many :comments, dependent: :destroy
    has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
    has_many :followers, through: :reverse_relationships, source: :follower
    has_many :relationships, foreign_key: "follower_id", dependent: :destroy
    has_many :followed_users, through: :relationships, source: :followed
  	
    # Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
  		:recoverable, :rememberable, :trackable, :validatable

    accepts_nested_attributes_for :profile, allow_destroy: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }

    def following?(other_user)
      relationships.find_by(followed_id: other_user.id)
    end

    def follow!(other_user)
      relationships.create!(followed_id: other_user.id)
    end

    def unfollow!(other_user)
      relationships.find_by(followed_id: other_user.id).destroy
    end

    def followers_count
      self.followers.count
    end

    def followers_count
      self.followers.count
    end

    def following_count
      self.followed_users.count
    end

    def pages_count
      self.pages.count
    end
end
