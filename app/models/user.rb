class User < ApplicationRecord
  has_many :user_matches
  has_many :user_cars
  has_many :matches, through: :user_matches
  has_many :cars, through: :user_cars

  has_secure_password
  has_secure_token

  # This method is not available in has_secure_token
  def invalidate_token
    update_columns(token: nil)
  end

  def self.valid_login?(email, password)
    user = find_by(email: email)
    if user&.authenticate(password)
      user
    end
  end
end
