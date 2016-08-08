FactoryGirl.define do
  factory :order do
    user

    after(:build) do |order|
      order.products << FactoryGirl.create_list(:product, 3)
    end
  end
end
