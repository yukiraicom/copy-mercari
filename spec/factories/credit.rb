FactoryGirl.define do
  factory :credit do
    card_number "00000000000000"
    expiration_month "1"
    expiration_year "19"
    security_code "000"
    user
    trait :with_another_user do
      association :user, factory: :user, email: "another@email"
    end
  end
end
