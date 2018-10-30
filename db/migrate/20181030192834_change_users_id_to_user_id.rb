class ChangeUsersIdToUserId < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_cars, :cars_id, :car_id
  end
end
