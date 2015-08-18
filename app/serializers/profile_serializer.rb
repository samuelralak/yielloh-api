class ProfileSerializer < ActiveModel::Serializer
	attributes :id, :avatar, :fullname, :username, :tagline, :location, 
		:twitter_handle, :facebook_handle, :date_of_birth, :gender_id, :user
  # has_one :user, serializer: UserSerializer
end
