class CreateCheapThreads < ActiveRecord::Migration[6.0]
  def change
    create_table :cheap_threads, id: :uuid do |t|
      t.integer :comment_number, default: 0, null: false
      t.string :title, null:false
      t.references :end_user, foreign_key: true
      t.references :list, foreign_key: true, null: false
      t.references :nanj, foreign_key: true, null: false

      t.timestamps
    end
  end
end