class MatchSerializer < ActiveModel::Serializer
  attributes :id, :seats, :seats_taken, :complete, :paragraph
  
  has_many :users
end
