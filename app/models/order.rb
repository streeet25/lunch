class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_items
  has_many  :products, through: :order_items, dependent: :destroy

  before_create :set_total!

  validate :validate_products

  def validate_products
    unless products.map(&:category_id).uniq.length == products.map(&:category_id).length && products.size == 3
      errors.add :products, 'Please select one product from each category'
    end
  end

  def user_name
    user.name
  end

  ransacker :created_at_casted do |parent|
    Arel.sql('date(orders.created_at)')
  end

  private

  def set_total!
    self.total = products.map(&:price).sum
  end

  def self.total_orders(orders)
    orders.map(&:total).sum if orders.present?
  end
end
