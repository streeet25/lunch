require 'spec_helper'

describe Category do
  before { @category = FactoryGirl.build(:category) }

  subject { @category }

  context 'associations' do
    it { should have_many(:products) }
  end

  context 'validations' do
    it { should be_valid }
    it { should validate_presence_of(:name) }
  end

  it { should respond_to(:name) }
end
