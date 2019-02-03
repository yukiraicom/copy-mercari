class AddAdressToUser < ActiveRecord::Migration[5.1]
  def change
    t.references :user, foreign_key: true
    t.string :first_name,  null: false, default: ""
    t.string :last_name,  null: false, default: ""
    t.string :first_name_kanai, null: false, default: ""
    t.string :last_name_kana, null: false, default: "" 
    t.integer :postal_code, null: false
    t.string :refecture, null: false 
    t.string :city, null: false
    t.string :street, null: false
    t.string :building_name, null: false
    t.integer :tel, null:false
  end
end