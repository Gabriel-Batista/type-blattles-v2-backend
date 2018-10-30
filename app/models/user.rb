class User < ApplicationRecord
  has_many :user_matches
  has_many :user_cars
  has_many :matches, through: :user_matches
  has_many :cars, through: :user_cars
end
