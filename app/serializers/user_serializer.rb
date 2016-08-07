class UserSerializer < ActiveModel::Serializer
  attributes :name, :email

  has_many :orders
end
