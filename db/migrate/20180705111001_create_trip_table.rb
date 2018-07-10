class CreateTripTable < ActiveRecord::Migration
  def up
    create_table :trips do |t|
      t.string :driver_emp_id
      t.string :origin
      t.string :destination
      t.timestamp :start_time
      t.integer :available_seats
    end
  end

  def down
  end
end
