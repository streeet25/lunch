require 'spec_helper'

describe SocialProfile do
  let(:profile) { build(:social_profile) }

  subject { profile }

  context 'associations' do
    it { should belong_to(:user) }
  end

  context 'validations' do
    it { should be_valid }
    it { should validate_presence_of(:service_name) }
    it { should validate_presence_of(:uid) }
    it { should validate_uniqueness_of(:service_name).scoped_to(:user_id) }
  end
end
