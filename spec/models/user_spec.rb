require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  subject { user }

  it { should respond_to(:email) }
  it { should respond_to(:organization_id) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:first_name) }
  context 'callbacks' do
    it { is_expected.to callback(:assign_role!).after(:create) }
    it { is_expected.to callback(:ensure_authentication_token).before(:save) }
    it { expect(user).to callback(:create_user_profile).after(:create) }
  end

  context 'validations' do
    it { should be_valid }
    it { should validate_presence_of(:first_name) }
  end

  it { should accept_nested_attributes_for :profile }

  context 'associations' do
    it { should belong_to(:organization) }
    it { should have_one(:profile) }
    it { should have_many(:orders) }
  end
end
