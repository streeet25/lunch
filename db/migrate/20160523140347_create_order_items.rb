class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references        :product, index: true
      t.references        :order, index: true
      t.decimal            :unit_price, precision: 12, scale: 3

      t.timestamps null: false
    end
  end
end
