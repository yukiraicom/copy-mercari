class CreateItem < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name, null: false, index: true
      t.string :condition, null: false
      t.integer :price, null: false
      t.string :description, null: false
      t.string :status, null: false
    end
  end
end
