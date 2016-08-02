FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "test#{n}user" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password '123456'
    password_confirmation '123456'
    profile
    association :organization

    factory :admin do
        after(:create) {|user| user.add_role(:admin)}
    end
  end
end
