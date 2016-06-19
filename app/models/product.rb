class Product < ActiveRecord::Base
  belongs_to :category

  has_many  :order_items
  has_many :orders, through: :order_items

  validates :name, :price, :category, presence: true

  delegate :name, to: :category, prefix: true
end
