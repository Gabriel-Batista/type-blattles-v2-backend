class AddEmailToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string
    add_column :users, :token, :string
    add_index :users, :token
  end
end
