class MatchSerializer < ActiveModel::Serializer
  attributes :id, :seats, :seats_taken, :complete
  
  has_many :users
end
