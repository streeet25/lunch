class ProductWeekday < ActiveRecord::Base
  belongs_to :product
  belongs_to :weekday
end
