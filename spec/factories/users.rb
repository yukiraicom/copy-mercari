FactoryGirl.define do
  factory :user do
    nickname "test"
    email Faker::Internet.email
    password "000000"
    profile "this is test profile"
  end
end
