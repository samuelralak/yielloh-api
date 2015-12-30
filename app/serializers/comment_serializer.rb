class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :user, :created_at

  has_one :user
end
