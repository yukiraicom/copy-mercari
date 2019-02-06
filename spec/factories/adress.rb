FactoryGirl.define do
  factory :adress do
    user
    first_name "山田"
    last_name "太郎"
    first_name_kana "ヤマダ"
    last_name_kana "タロウ"
    postal_code "0000000"
    prefecture "北海道"
    city "tokyo"
    street "shibuya"
    building_name "109"
    tel "0123456789"
  end
end
