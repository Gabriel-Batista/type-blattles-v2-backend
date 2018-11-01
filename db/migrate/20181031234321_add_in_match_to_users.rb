class AddInMatchToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :in_match, :boolean
  end
end
