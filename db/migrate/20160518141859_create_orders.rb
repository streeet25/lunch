class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer	:user_id
      t.decimal	:total

      t.timestamps null: false
    end

    add_index :orders, :user_id
  end
end
