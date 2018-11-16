class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :in_match, :current_match

  def current_match
    current_match = object.matches.find_by(complete: false)
    if current_match
      return current_match
    else
      return nil
    end
  end
end
