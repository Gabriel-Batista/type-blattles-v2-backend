class AddCompleteToMatch < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :complete, :boolean, default: false
  end
end
