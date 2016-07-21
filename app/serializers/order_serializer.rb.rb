require 'orders'

class OrderSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :total

  has_one :user
end
