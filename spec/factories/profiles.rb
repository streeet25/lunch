FactoryGirl.define do
  factory :profile do
    sequence(:last_name) { |n| "last_name#{n}" }
  end
end
