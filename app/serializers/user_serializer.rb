class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :in_match
end
