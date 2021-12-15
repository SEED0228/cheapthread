class CreateNanjs < ActiveRecord::Migration[6.0]
  def change
    create_table :nanjs do |t|
      t.string :ip_address, null: false
      t.string :random_number, null: false

      t.timestamps
    end
  end
end
