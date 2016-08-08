require 'spec_helper'

describe Weekday do
  let(:weekday) { build(:weekday) }

  subject { weekday }

  context 'associations' do
    it { should have_many(:product_weekdays) }
    it { should have_many(:products).through(:product_weekdays) }
  end

  context 'validations' do
    it { should be_valid }
    it { should validate_presence_of(:name) }
  end
end
