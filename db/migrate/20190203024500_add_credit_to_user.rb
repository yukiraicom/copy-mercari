class AddCreditToUser < ActiveRecord::Migration[5.1]
  def change
    t.references :user, foreign_key: true
    t.integer :card_number, null: false
    t.integer :expiration_month, null: false
    t.integer :expiration_year, null: false
    t.integer :security_code, null: false
  end
end
