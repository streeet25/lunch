class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_items
  has_many  :products, through: :order_items, dependent: :destroy

  before_create :set_total!

  private

    def set_total!
      self.total = products.map(&:price).sum
    end
end
