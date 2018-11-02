class AddDefaultToSeatsTaken < ActiveRecord::Migration[5.2]
  def change
    change_column :matches, :seats_taken, :integer, default: 1
  end
end
