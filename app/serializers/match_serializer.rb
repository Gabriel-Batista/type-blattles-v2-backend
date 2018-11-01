class MatchSerializer < ActiveModel::Serializer
  attributes :id, :seats, :seats_taken
  
  has_many :users
end
