class ChangeViewCounterOfList < ActiveRecord::Migration[6.0]
  def change
    change_column :lists, :view_counter,  :integer, default: 0
  end
end
