class AddPayjpToCredit < ActiveRecord::Migration[5.1]
  def change
    add_column :credits, :pay_id, :string
    add_column :credits, :customer_id, :string
  end
end
