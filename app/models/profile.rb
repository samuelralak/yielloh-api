class Profile < ActiveRecord::Base
  belongs_to :user

	# validates :fullname, presence: true, :on => :update
	validates :username, presence: true, uniqueness: { case_sensitive: false }
	# validates :user_id, presence: true, uniqueness: { message: "Profile already exists" }

	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/default-avatar.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_attached_file :cover_photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/default-cover.png"
  validates_attachment_content_type :cover_photo, :content_type => /\Aimage\/.*\Z/

  after_save :assign_gender

  protected
  	def assign_gender
  		if !self.gender.nil? && (self.gender.upcase.eql?('MALE') || self.gender.upcase.eql?('FEMALE'))
  			self.gender_id = Gender.find_by(code: self.gender.upcase).id
  		end
  	end
end
