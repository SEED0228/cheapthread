class CreateThreadComments < ActiveRecord::Migration[6.0]
  def change
    create_table :thread_comments, id: :uuid do |t|
      t.text :comment, null: false
      t.string :user_id, null: false
      t.references :end_user, foreign_key: true
      t.references :cheap_thread, type: :uuid, foreign_key: true, null: false
      t.references :nanj, foreign_key: true

      t.timestamps
    end
  end
end
