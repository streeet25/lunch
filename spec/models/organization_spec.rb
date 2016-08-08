require 'spec_helper'

describe Organization do
  before { @organization = FactoryGirl.build(:organization) }

  subject { @organization }

  context 'associations' do
    it { should have_many(:users) }
  end

  context 'validations' do
    it { should be_valid }
    it { should validate_presence_of(:name) }
  end

  it { should respond_to(:name) }
end
