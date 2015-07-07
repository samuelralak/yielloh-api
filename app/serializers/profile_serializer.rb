class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :avatar, :fullname, :username, :about, :location, :user
  # has_one :user, serializer: UserSerializer
end
