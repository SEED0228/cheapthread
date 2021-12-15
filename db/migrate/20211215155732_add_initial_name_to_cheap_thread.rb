class AddInitialNameToCheapThread < ActiveRecord::Migration[6.0]
  def change
    add_column :cheap_threads, :initial_name, :string, default: "風吹けば名無し"
  end
end
