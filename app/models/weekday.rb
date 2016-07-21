class Weekday < ActiveRecord::Base
  resourcify

  has_many :product_weekdays
  has_many :products, through: :product_weekdays, dependent: :destroy

  def self.find_products(category)
    date = DateTime.now.to_date.strftime('%A')
    find_by_name(date).products.where(category: category)
  end
end
