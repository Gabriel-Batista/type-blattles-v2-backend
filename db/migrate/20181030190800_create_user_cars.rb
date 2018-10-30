class CreateUserCars < ActiveRecord::Migration[5.2]
  def change
    create_table :user_cars do |t|
      t.integer :user_id
      t.integer :cars_id
      t.timestamps
    end
  end
end
