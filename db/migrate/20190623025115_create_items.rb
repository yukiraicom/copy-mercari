class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name, null: false, index: true
      t.integer :condition, null: false
      t.integer :price, null: false
      t.string :description, null: false
      t.integer :postage, null: false
      t.integer :ship_from, null: false
      t.integer :days_before_shipment, null: false
    end
  end
end
