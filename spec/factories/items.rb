# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    name {"sample1"}
    condition 1
    price 3000
    description {"this is sample"}
    status 1
  end
end
