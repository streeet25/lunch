require 'spec_helper'

describe OrderItem do
  before { @order_product = FactoryGirl.build(:order_item) }

  subject { @order_product }

  it { should respond_to(:order_id) }
  it { should respond_to(:product_id) }

  it { should belong_to(:order) }
  it { should belong_to(:product) }
end
