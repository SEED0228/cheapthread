class AddCalorieToListElement < ActiveRecord::Migration[6.0]
  def change
    add_column  :list_elements, :calorie, :integer
    add_column  :lists,  :add_calorie, :boolean, default: false
    add_column  :lists,  :is_public, :boolean, default: true
  end
end
