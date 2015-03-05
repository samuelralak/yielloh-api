class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :fullname, :username, :about, :location, :user
  # has_one :user, serializer: UserSerializer
end
