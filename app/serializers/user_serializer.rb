class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :profile, :interest_list

  has_one :profile
end
