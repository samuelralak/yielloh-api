class Page < ActiveRecord::Base
    belongs_to :user, inverse_of: :pages

    has_many :posts, inverse_of: :page

    validates :title, presence: true

    has_attached_file :cover, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/default-cover.png"
  	validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/
end
