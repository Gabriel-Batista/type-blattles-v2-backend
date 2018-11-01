class AddDefaultToInMatchInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :in_match, :boolean, default: false
  end
end
