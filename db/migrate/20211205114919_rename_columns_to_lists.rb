class RenameColumnsToLists < ActiveRecord::Migration[6.0]
  def change
    rename_column :lists, :add_price_element, :contains_price
    rename_column :lists, :add_calorie, :contains_calorie
  end
end
