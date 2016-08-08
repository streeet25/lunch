require 'spec_helper'

describe Order do
  let(:weekday) { FactoryGirl.create(:weekday, name: 'weekday') }
  let(:date) { Date.today }
  let(:order) { FactoryGirl.create(:order, created_at: date) }
  let(:categories) { create_list(:category, 3) }
  let(:products) { create_list(:product, 3) }

  subject { order }

  it { should respond_to(:user_id) }
  it { should respond_to(:total) }

  it { should be_valid }

  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:order_items) }
    it { should have_many(:products).through(:order_items) }
  end

  context 'validations' do
    it 'when one item from each category is valid' do
      order.products = products

      expect(order).to be_valid
    end

    it 'when category is not unique' do
      products_category = [weekday.products[0], weekday.products[1], weekday.products[1]]
      order.products = products_category

      expect(order).to_not be_valid
    end

    it 'when items is not equal 3' do
      products = [weekday.products[0], weekday.products[1]]
      order.products = products

      expect(order).to_not be_valid
    end
  end

  describe '#set_total!' do
    it 'calculate the total price of the order' do
      order.products = products

      order.send(:set_total!)
      expect(order.total).to eq(weekday.products[0].price + weekday.products[1].price + weekday.products[2].price)
    end
  end
end
