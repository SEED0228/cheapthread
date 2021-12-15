class AddColumnsToThreadComment < ActiveRecord::Migration[6.0]
  def change
    add_column :thread_comments, :name, :string
    add_column :thread_comments, :email, :string
  end
end
