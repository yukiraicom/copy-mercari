FactoryGirl.define do
  factory :user do
    nickname "test"
    sequence(:email) {Faker::Internet.email}
    password "000000"
    profile "this is test profile"
  end
end
