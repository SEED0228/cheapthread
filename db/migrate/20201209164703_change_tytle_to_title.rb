class ChangeTytleToTitle < ActiveRecord::Migration[6.0]
  def change
    rename_column :lists, :tytle,  :title
  end
end
