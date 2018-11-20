class AddAuthorToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :author, :string
  end
end
