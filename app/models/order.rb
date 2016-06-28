class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_items
  has_many  :products, through: :order_items, dependent: :destroy

  before_create :set_total!

  private

  def set_total!
    self.total = products.map(&:price).sum
  end

  def self.getOrders
    date = Date.today
    @orders = Order.where(created_at: date..date.end_of_day)
    @orders.to_json
  end

  def self.find_orders(date_params)
    if date_params
      date = date_params.to_date
    else
      date = Date.today
    end
    Order.where(created_at: date..date.end_of_day).order(id: :desc) if date.present?
  end

  def self.date_orders(date_params)
    if date_params
      date = date_params.to_date
    else
      date = Date.today
    end
  end

  def self.total_orders(orders)
    orders.map(&:total).sum if orders.present?
  end
end
