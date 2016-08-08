class Product < ActiveRecord::Base
  resourcify
  belongs_to :category

  has_many :order_items
  has_many :orders, through: :order_items

  has_many :product_weekdays
  has_many :weekdays, through: :product_weekdays

  validates :name, :price, :category, presence: true

  delegate :name, to: :category, prefix: true

  def name_price
    "#{name}, #{price}"
  end
end
