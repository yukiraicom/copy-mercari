class AddColumnToItem < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :status, :int, null: false
  end
end
