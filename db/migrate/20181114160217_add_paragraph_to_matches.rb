class AddParagraphToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :paragraph, :string
  end
end
