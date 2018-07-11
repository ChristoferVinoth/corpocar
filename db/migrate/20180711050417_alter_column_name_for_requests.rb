class AlterColumnNameForRequests < ActiveRecord::Migration
  def change
    rename_column :requests, :rider_emp_id, :rider_id
  end
end
