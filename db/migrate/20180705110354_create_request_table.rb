class CreateRequestTable < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string  :rider_emp_id
      t.integer :trip_id
      t.boolean :confirmed
    end
  end

end
