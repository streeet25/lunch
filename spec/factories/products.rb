FactoryGirl.define do
  factory :product do
    sequence(:name) { |n| "name#{n}" }
    price '85'
    category
  end
end
