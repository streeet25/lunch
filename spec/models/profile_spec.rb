require 'spec_helper'

describe Profile do
  let(:profile) { build(:profile) }

  subject { profile }

  context 'associations' do
    it { should belong_to(:user).inverse_of(:profile) }
  end

  context 'validations' do
    it { should be_valid }
    it { should validate_presence_of(:last_name) }
  end
end
