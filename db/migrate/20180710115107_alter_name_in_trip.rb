class AlterNameInTrip < ActiveRecord::Migration
  def change
    rename_column :trips, :driver_emp_id, :driver_id
  end
end
