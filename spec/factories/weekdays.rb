FactoryGirl.define do
  factory :weekday do
    name { DateTime.now.to_date.strftime('%A') }
    products do
      create_list(:product, 3, category: create(:category)) + create_list(:product, 3, category: create(:category)) + create_list(:product, 3, category: create(:category))
    end
  end
end
