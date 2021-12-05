class ChangeCalorieDefaultToListElements < ActiveRecord::Migration[6.0]
  def change
    change_column :list_elements, :calorie,:integer, default: 0
  end
end
