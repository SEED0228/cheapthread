class AddColorToLists < ActiveRecord::Migration[6.0]
  def change
    add_column :lists, :color, :string, default: "#007c00", null: false
    add_column :lists, :text_color, :string, default: "#d70002", null: false
  end
end
