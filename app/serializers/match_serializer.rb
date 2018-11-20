class MatchSerializer < ActiveModel::Serializer
  attributes :id, :seats, :seats_taken, :complete, :paragraph, :author
  has_many :users
end
