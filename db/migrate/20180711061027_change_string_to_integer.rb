class ChangeStringToInteger < ActiveRecord::Migration
  def change
    change_column :requests, :rider_id, :integer
    change_column :trips, :driver_id, :integer
    change_column :users, :employee_id, :integer
  end
end
