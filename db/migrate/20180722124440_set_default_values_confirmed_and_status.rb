class SetDefaultValuesConfirmedAndStatus < ActiveRecord::Migration
  def change
    change_column :requests, :confirmed, :boolean, :default => false
    change_column :trips, :status, :string, :default => 'created'
  end
end
