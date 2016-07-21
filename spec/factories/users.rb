FactoryGirl.define do
  factory :user do
    name 'Test User'
    sequence(:email) { |n| "test#{n}@example.com" }
    password '123456'
    password_confirmation '123456'

    factory :admin do
        after(:create) {|user| user.add_role(:admin)}
    end
  end
end
