FactoryGirl.define do
  factory :credit do
    user
    card_number "00000000000000"
    expiration_month "1"
    expiration_year "19"
    security_code "000"
  end
end
