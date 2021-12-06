class ChangeDataListIdToListElements < ActiveRecord::Migration[6.0]
  def change
    change_column :list_elements, :list_id, 'integer USING CAST(list_id AS integer)'
  end
end
