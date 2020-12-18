class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.integer :view_counter, null: false
      t.string :tytle, null: false
      t.text :introduction
      t.boolean :add_price_element, null: false, default: true 
      t.integer :end_user_id, null: false

      t.timestamps
    end
    add_index :lists, :tytle,  unique: true
  end
end
