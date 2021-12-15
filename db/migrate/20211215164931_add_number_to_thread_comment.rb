class AddNumberToThreadComment < ActiveRecord::Migration[6.0]
  def change
    add_column :thread_comments, :number, :integer, null: :false
  end
end
