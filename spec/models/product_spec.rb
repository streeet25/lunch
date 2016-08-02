require 'spec_helper'

describe Product do
  let(:product) {  build(:product) }

  subject { product }

  context 'associations' do
    it { should belong_to(:category) }

    it { should have_many(:order_items) }
    it { should have_many(:orders).through(:order_items) }

    it { should have_many(:product_weekdays) }
    it { should have_many(:weekdays).through(:product_weekdays) }
  end

  context 'validations' do
    it { should be_valid }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:category) }
    it { should delegate_method(:name).to(:category).with_prefix(true) }
  end

end
