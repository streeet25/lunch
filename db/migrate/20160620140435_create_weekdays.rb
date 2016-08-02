class CreateWeekdays < ActiveRecord::Migration
  def change
    create_table :weekdays do |t|
    	t.string		:name
      t.date           :date

      t.timestamps null: false
    end
  end
end
