class CreateProductWeekdays < ActiveRecord::Migration
  def change
    create_table :product_weekdays do |t|
      t.belongs_to :product, index: true
      t.belongs_to :weekday, index: true

      t.timestamps null: false
    end
  end
end
