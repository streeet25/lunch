require 'spec_helper'

describe ProductWeekday do
  before { @product_weekday = FactoryGirl.build(:product_weekday) }

  subject { @product_weekday }

  it { should respond_to(:product_id) }
  it { should respond_to(:weekday_id) }

  it { should belong_to(:product) }
  it { should belong_to(:weekday) }

end
