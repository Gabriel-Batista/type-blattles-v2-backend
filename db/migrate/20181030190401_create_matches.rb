class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.integer :seats
      t.integer :seats_taken
      t.timestamps
    end
  end
end
