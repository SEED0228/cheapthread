class ChangePriceToListElement < ActiveRecord::Migration[6.0]
  def change
    change_column_null :list_elements, :price,  true, 0
    change_column :list_elements, :price, :integer, default: 0
  end
end
