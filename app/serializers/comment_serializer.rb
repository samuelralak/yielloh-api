class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :user
end
