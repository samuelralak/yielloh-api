class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :avatar, :fullname, :username, :about, :location, :twitter_handle, :facebook_handle, :user
  # has_one :user, serializer: UserSerializer
end
