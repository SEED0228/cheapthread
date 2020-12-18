class CreateListElements < ActiveRecord::Migration[6.0]
  def change
    create_table :list_elements do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.text :introduction
      t.string :list_id, null: false

      t.timestamps
    end
    add_index :list_elements, :name
  end
end
