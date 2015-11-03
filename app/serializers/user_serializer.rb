class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :profile, :interest_list, :followers_count, :following_count, :pages_count

  has_one :profile
end
